//
//  WIFISevice.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/15.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WIFISevice.h"

#import<SystemConfiguration/CaptiveNetwork.h>
#import <AFNetworking/AFNetworking.h>
#import <NetworkExtension/NetworkExtension.h>
#import "NSString+Additions.h"
#import "WIFIPusher.h"
#import "WifiUtil.h"
#import "WIFIValidator.h"
#import "EasyCacheHelper.h"

static NSInteger flowRequestNum = 0;

@interface WIFISevice()

@property (nonatomic,assign)WINetStatus net_status;
@property (nonatomic,assign)float lastWifiSentFlow;
@property (nonatomic,assign)BOOL validateSuccess;
@property (nonatomic,strong)dispatch_queue_t validateQueque;


@end

@implementation WIFISevice

+ (instancetype)shared {
    static WIFISevice *manager = nil;
    static dispatch_once_t once_tokn;
    dispatch_once(&once_tokn, ^{
        manager = [[self alloc]init];
    });
    return manager;
}

- (id)init {
    if (self = [super init]) {
        dispatch_queue_t queue = dispatch_queue_create("WIHKTWIFIVALIDATEQUEUE", NULL);
        self.validateQueque = queue;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleWhenUserLogout:) name:WILogoutSuccessNoti object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleWhenUserLogin:) name:WILoginSuccessNoti object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(wiApplicationWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(validateSuccess:) name:WIFIValidatorSuccessNoti object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(validateFail:) name:WIFIValidatorFailNoti object:nil];
        
        self.delegate = self;
        self.wifiInfo = [WIFIInfo new];
        self.hktWifiArray = [NSMutableArray array];
        self.otherWifiArray = [NSMutableArray array];
        NSString *cachOrgId = [[NSUserDefaults standardUserDefaults]objectForKey:LASTHKTWIFIORGIDKEY];
        if (cachOrgId) {
             self.wifiInfo.orgId = [cachOrgId copy];
        } else {
            self.wifiInfo.orgId = @"8a8ab0b246dc81120146dc8180ba0017";
        }
        [WIFIPusher requestAuthor];
        [self scanWifiList];
       
    }
    return self;
}


//定时流量监测
- (void)startFlowMonitor {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    self.timer = _timer;
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),60.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        if ([AccountManager shared].user.userId) {
            [self findUserFLow];
            [self saveUserFlow];
        }
    });
    dispatch_resume(self.timer);
}

- (void)scanWifiList {
    NSLog(@"1.Start");
    NSMutableDictionary* options = [[NSMutableDictionary alloc] init];
    [options setObject:@"华宽通无线城市😄wifi" forKey: kNEHotspotHelperOptionDisplayName];
    dispatch_queue_t queue = dispatch_queue_create("WIHKTWIFISEARCHQUEUE", NULL);
    
    NSLog(@"2.Try");
    BOOL returnType = [NEHotspotHelper registerWithOptions: options queue: queue handler: ^(NEHotspotHelperCommand * cmd) {
        
        NSLog(@"4.Finish");
        NEHotspotNetwork* network;
        if ( cmd.commandType == kNEHotspotHelperCommandTypeFilterScanList ) {
            NSLog(@"-------华宽通wifi正在扫描------");
            for (network in cmd.networkList) {
                NSString* wifiInfoString = [[NSString alloc] initWithFormat: @"---------------------------\nSSID: %@\nMac地址: %@\n信号强度: %f\nCommandType:%ld\n---------------------------\n\n", network.SSID, network.BSSID, network.signalStrength, (long)cmd.commandType];
                NSLog(@"附近wifi信息%@", wifiInfoString);

                if (![network.BSSID  hasPrefix:HKTWIFIMACPREFIX]) {
                    BOOL otherwifiAdded = NO;
                    for (int i = 0; i < self.otherWifiArray.count;i++) {
                        WIFIInfo *info = self.otherWifiArray[i];
                        if ([info.sid isEqualToString:network.SSID]) {
                            otherwifiAdded = YES;
                            break;
                        }
                        
                    }
                    if (otherwifiAdded == YES) {
                        continue;
                    } else {
                        WIFIInfo *info = [WIFIInfo new];
                        info.bsid = [network.BSSID copy];
                        info.signalStrength = [NSString stringWithFormat:@"%.2f",network.signalStrength];
                        info.sid = [network.SSID copy];
                        [self.otherWifiArray addObject:info];
                        continue;
                    }
                }
                BOOL wifiAdded = NO;
                for (int i = 0; i < self.hktWifiArray.count; i++) {
                    WIFIInfo *info = self.hktWifiArray[i];
                    if ([info.sid isEqualToString:network.SSID]) {
                        wifiAdded = YES;
                        break;
                    }
                }
                if (wifiAdded == YES) {
                    continue;
                }
                if ([network.BSSID  hasPrefix:HKTWIFIMACPREFIX]) {
                    WIFIInfo *info = [WIFIInfo new];
                    info.bsid = [network.BSSID copy];
                    info.signalStrength = [NSString stringWithFormat:@"%.2f",network.signalStrength];
                    info.sid = [network.SSID copy];
                    [self.hktWifiArray addObject:info];
//                    [network setConfidence: kNEHotspotHelperConfidenceHigh];
//                    [network setPassword: @""];
//                    NEHotspotHelperResponse *response = [cmd createResponse: kNEHotspotHelperResultSuccess];
//                    [response setNetworkList: @[network]];
//                    [response setNetwork: network];
//                    [response deliver];
                }
            }
            if (self.hktWifiArray && self.hktWifiArray.count > 0) {
                [EasyCacheHelper saveResponseCache:[self.hktWifiArray copy] forKey:HKTWIFIARRAYKEY];
            }
            if (self.otherWifiArray && self.otherWifiArray.count > 0) {
                [EasyCacheHelper saveResponseCache:[self.otherWifiArray copy] forKey:OHERWIFIARRAYKEY];
            }
            
            
           
        } else if (cmd.commandType == 2) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//               [WIFIPusher sendWIFINoti];
//            });
            NSLog(@"-------华宽通wifi正在认证------");
//            dispatch_async(dispatch_get_main_queue(), ^{
//               [[WIFIValidator shared]validator];
//            });
            
        } else {
            NSLog(@"-------华宽通wifi其他状态------");
        }

        
    }];
    NSLog(@"3.Result: %@", returnType == YES ? @"Yes" : @"No");
}

- (void)applicationConnectWifi:(WIFIInfo *)info {
    if (@available(iOS 11.0, *)) {
        NEHotspotConfiguration * hotspotConfig = [[NEHotspotConfiguration alloc] initWithSSID:info.sid];
        [Dialog progressToast:@"正在准备切换网络"];
        [[NEHotspotConfigurationManager sharedManager] applyConfiguration:hotspotConfig completionHandler:^(NSError * _Nullable error) {
            if (error.code == 7) {
                [MBProgressHUD hideAllHUDsForView:KWINDOW animated:YES];
                return ;
            }
            if (error.code == 13) {
                [MBProgressHUD hideAllHUDsForView:KWINDOW animated:NO];
                if ([WIFISevice netStatus] == WINetFail) {
                    [Dialog simpleToast:@"正在帮你重新认证"];
                    [WIFIValidator shared].reconnect = YES;
                    [[WIFIValidator shared]validator];
                } else {
                    [Dialog simpleToast:@"当前wifi已连接"];
                }
                
            } else {
                [MBProgressHUD hideAllHUDsForView:KWINDOW animated:YES];
                [[WIFIValidator shared]validator];
            }
            NSLog(@"%@", error.localizedDescription);
        }];
    }

}

- (void)setNetMonitor {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"%ld",status);
        if (status == AFNetworkReachabilityStatusNotReachable) {
            self.net_status = WINetFail;
            if (!self.validating && [WIFISevice netStatus] == WINetFail) {
                [Dialog simpleToast:kNetError];
            }

        } else if ( status == AFNetworkReachabilityStatusReachableViaWWAN ) {
            self.net_status = WINet4G;
        } else if ( status == AFNetworkReachabilityStatusUnknown) {
            self.net_status = WINetFail;
        } else {
            self.net_status = WINetWifi;
            self.wifiInfo.sid = [WifiUtil getWifiName];
            self.wifiInfo.bsid = [WifiUtil getWifiMac];
            if ([WIFISevice isHKTWifi] ) {
                [[WIFIValidator shared]validator];
            }
        }
        NSLog(@"wifi status : %ld",self.net_status);
        [self handleWhenNetChange:[WIFISevice netStatus]];
        if (self.panelDelegate && [self.panelDelegate respondsToSelector:@selector(handleWhenNetChange:wifiInfo:)]) {
            [self.panelDelegate handleWhenNetChange:self.net_status wifiInfo:self.wifiCloudInfo];
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:@"WINETSTATUSCHANGE" object:nil];
    }];
    
    [manager startMonitoring];
}

#pragma mark - 上传下载用户最新流量
- (void)findUserFLow {
    NSDictionary *para = @{@"userId":[AccountManager shared].user.userId};
    if (![WIFISevice isHKTWifi]) {
        return;
    }
    [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, FindUserFLowAPI) params:para successBlock:^(NSDictionary *returnData) {
        self.wifiCloudInfo = [[WIFICloudInfo alloc]initWithDictionary:[returnData objectForKey:@"obj"] error:nil];
        if (self.panelDelegate && [self.panelDelegate respondsToSelector:@selector(wifiPanelRefreshWifiInfo:)]) {
            [self.panelDelegate wifiPanelRefreshWifiInfo:self.wifiCloudInfo];
        }
    
    } failureBlock:^(NSError *error) {
        
    } showHUD:NO];
}

- (void)handleWhenNetChange:(WINetStatus)status wifiInfo:(WIFIInfo*)info {
    if (status == WINetFail && !self.validating) {
        [Dialog simpleToast:@"网络连接失败"];
    }
}

- (void)saveUserFlow {
    if (![WIFISevice isHKTWifi]) {
        return;
    }
    WIFIFlow *flow =  [WifiUtil checkNetworkflow];
    if (flowRequestNum == 0) {
        self.lastWifiSentFlow = [flow.wifiSent floatValue];
        flowRequestNum++;
        return;
    }
    float addFlowNumber = [flow.wifiSent floatValue] - self.lastWifiSentFlow;
    if (addFlowNumber <= 0 ) {
        return;
    }
    NSDictionary *para = @{@"flowNumber":[NSString stringWithFormat:@"%.2f",addFlowNumber],@"userId":[AccountManager shared].user.userId};
    [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, SaveUserFlowAPI) params:para successBlock:^(NSDictionary *returnData) {
        WIFIFlow *flow =  [WifiUtil checkNetworkflow];
        self.lastWifiSentFlow = [flow.wifiSent floatValue];
    } failureBlock:^(NSError *error) {
        
    } showHUD:NO];
    
}

#pragma mark - 更新orgid
- (void)requestOrgId:(NSString *)mac {
    NSString *regular = [WifiUtil getRegularMac];
    [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, GetMacOrgId) params:@{@"mac":regular} successBlock:^(NSDictionary *returnData) {
        NSString *msg = [returnData objectForKey:@"msg"];
        NSLog(@"机构id获取:%@",msg);
        WINetResponse *response = [[WINetResponse alloc]initWithDictionary:returnData error:nil];
        if (response.success) {
            NSString *orgId = [response.attributes objectForKey:@"orgId"];
            if (orgId && ![orgId isEqualToString:self.wifiInfo.orgId]) {
                if (orgId.length > 1) {
                    [[NSUserDefaults standardUserDefaults]setObject:orgId forKey:LASTHKTWIFIORGIDKEY];
                }
                [[NSNotificationCenter defaultCenter]postNotificationName:WIOrgIDChangeNoti object:nil];
                self.wifiInfo.orgId = [response.attributes objectForKey:@"orgId"];
                self.wifiInfo.endTime = [response.attributes objectForKey:@"endTime"];
            }
            
        }
    } failureBlock:^(NSError *error) {
        
    } showHUD:NO];
    
}

#pragma mark - notification

- (void)validateSuccess:(NSNotification *)noti {
    [self requestOrgId:[WifiUtil getWifiMac]];
}

- (void)validateFail:(NSNotification *)noti {


}

- (void)wiApplicationWillEnterForeground:(NSNotification *)noti {
    NSString *wifiMac = [WifiUtil getWifiMac];
    self.wifiInfo.sid = [WifiUtil getWifiName];
    self.wifiInfo.bsid = [wifiMac copy];
    if (wifiMac && [WIFISevice isHKTWifi]) {
        [[WIFIValidator shared]validator];
    }

    if (self.panelDelegate && [self.panelDelegate respondsToSelector:@selector(handleWhenNetChange:wifiInfo:)]) {
        [self.panelDelegate handleWhenNetChange:[WIFISevice netStatus] wifiInfo:self.wifiCloudInfo];
    }
    
}

- (void)handleWhenUserLogin:(NSNotification *)noti {
    [self startFlowMonitor];
}

- (void)handleWhenUserLogout:(NSNotification *)noti {
    dispatch_cancel(self.timer);
}

#pragma mark - wifi connect

- (void)connectWifi {
    [WifiUtil openWifiSetting];
}

#pragma mark - wifi change

- (void)handleWhenNetChange:(WINetStatus)status {
    if (status == WINetFail || status == WINet4G) {
        if (self.timer) {
            dispatch_cancel(self.timer);
            self.timer = nil;
        }
        
        
    } else {
        if (self.timer) {
            dispatch_cancel(self.timer);
            self.timer = nil;
        }
        [self startFlowMonitor];
    }
}

#pragma mark - get
+ (WINetStatus)netStatus {
    if ( [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusUnknown || [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        NSLog(@"网络连接失败");
        return WINetFail;
    } else if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusReachableViaWWAN) {
        return WINet4G;
    } else {
        NSLog(@"网络连接wifi");
        return WINetWifi;
    }
    
}

+(BOOL)isHKTWifi {
    NSString *wifiName = [WifiUtil getWifiMac];
    if ([wifiName hasPrefix:HKTWIFIMACPREFIX]) {
        return YES;
    } else {
        return NO;
    }
}

@end
