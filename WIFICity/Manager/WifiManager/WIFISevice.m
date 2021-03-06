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
static NSString *const defaultOrgId = @"8a8ab0b246dc81120146dc8180ba0017";
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
//        NSString *cachOrgId = [[NSUserDefaults standardUserDefaults]objectForKey:LASTHKTWIFIORGIDKEY];
//        if (cachOrgId) {
//             self.wifiInfo.orgId = [cachOrgId copy];
//        } else {
            self.wifiInfo.orgId = @"8a8ab0b246dc81120146dc8180ba0017";
//        }
        [WIFIPusher requestAuthor];
        [self scanWifiList];
       
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self name:WILogoutSuccessNoti object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:WILoginSuccessNoti object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:WIFIValidatorSuccessNoti object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:WIFIValidatorFailNoti object:nil];


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
    BOOL returnType = [NEHotspotHelper registerWithOptions: options queue: queue handler: ^(NEHotspotHelperCommand * cmd) {
        NEHotspotNetwork* network;
        NSMutableArray *networkList = [NSMutableArray array];
        if ( cmd.commandType == kNEHotspotHelperCommandTypeFilterScanList ) {
            NSLog(@"-------华宽通wifi正在扫描------");
            for (network in cmd.networkList) {
//                NSString* wifiInfoString = [[NSString alloc] initWithFormat: @"---------------------------\nSSID: %@\nMac地址: %@\n信号强度: %f\nCommandType:%ld\n---------------------------\n\n", network.SSID, network.BSSID, network.signalStrength, (long)cmd.commandType];
//                NSLog(@"附近wifi信息%@", wifiInfoString);
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
//                    [networkList addObject:network];
//                    NEHotspotHelperResponse *response = [cmd createResponse: kNEHotspotHelperResultSuccess];
//                    [response setNetworkList: [networkList copy]];
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

            NSLog(@"-------华宽通wifi正在认证------");
            
        } else {
            NSLog(@"-------华宽通wifi其他状态------");
        }

        
    }];
    NSLog(@"3.Result: %@", returnType == YES ? @"Yes" : @"No");
}

- (void)getOtTime:(NSString *)orgid {
    NSDictionary *par = @{@"id":orgid};
    NSLog(@"网络超时参数%@",par);
    [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, FindOTByOrgId) params:par successBlock:^(NSDictionary *returnData) {
        NSDictionary *atr = [returnData objectForKey:@"attributes"];
        if (atr) {
            NSInteger ot = [[atr objectForKey:@"endTime"]integerValue];
            NSInteger otNum =  [[atr objectForKey:@"endTimeNumber"]integerValue];
            if (ot > 0) {
                [WIFISevice shared].wifiInfo.shijiancuo = ot;
                [WIFISevice shared].wifiInfo.otNum = otNum;
                
                NSInteger cachOtnum = [[[NSUserDefaults standardUserDefaults]objectForKey:LastWiFiOrgID_OutTime_Key]integerValue];
                if (cachOtnum != otNum) {
                    [[WIFIValidator shared]validator];
                    [WIFIValidator shared].reconnect = YES;
                    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%ld",otNum] forKey:LastWiFiOrgID_OutTime_Key];
                    NSLog(@"再次认证上网超时时间: %ld",otNum);
                }
            }
        }
    } failureBlock:^(NSError *error) {
        
    } showHUD:NO];
}

- (void)applicationConnectWifi:(WIFIInfo *)info {
    if (@available(iOS 11.0, *)) {
        NEHotspotConfiguration * hotspotConfig = [[NEHotspotConfiguration alloc] initWithSSID:info.sid];
        [Dialog progressToast:@"正在准备切换网络"];
        [[NEHotspotConfigurationManager sharedManager] applyConfiguration:hotspotConfig completionHandler:^(NSError * _Nullable error) {
            [MBProgressHUD hideAllHUDsForView:KWINDOW animated:YES];
            if (error.code == 7) {
                return ;
            }
            if (error.code == 13) {
                if ([WIFISevice netStatus] == WINetFail) {
                    [Dialog simpleToast:@"正在帮你重新认证"];
                    [WIFIValidator shared].resetExpireTime = YES;
                    [[WIFIValidator shared]validator];
                } else {
                    [Dialog simpleToast:@"当前wifi已连接"];
                }
                
            } else {
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
        flowRequestNum = 0;
        if (status == AFNetworkReachabilityStatusNotReachable) {
            self.net_status = WINetFail;
            [Dialog simpleToast:kNetError];
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
        [[NSNotificationCenter defaultCenter]postNotificationName:@"WINetStatus_Change_Noti" object:nil];
    }];
    
    [manager startMonitoring];
}

#pragma mark - 上传下载用户最新流量
- (void)findUserFLow {
    NSDictionary *para = @{@"userId":[AccountManager shared].user.userId};
    [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, FindUserFLowAPI) params:para successBlock:^(NSDictionary *returnData) {
        self.wifiCloudInfo = [[WIFICloudInfo alloc]initWithDictionary:[returnData objectForKey:@"obj"] error:nil];
        if (self.panelDelegate && [self.panelDelegate respondsToSelector:@selector(wifiPanelRefreshWifiInfo:)]) {
            [self.panelDelegate wifiPanelRefreshWifiInfo:self.wifiCloudInfo];
        }
    
    } failureBlock:^(NSError *error) {
        
    } showHUD:NO];
}

- (void)handleWhenNetChange:(WINetStatus)status wifiInfo:(WIFIInfo*)info {

}

- (void)saveUserFlow {
    if (![WIFISevice isHKTWifi] || [WIFISevice netStatus] == WINet4G || [WIFISevice netStatus] == WINetFail) {
        return;
    }
    WIFIFlow *flow =  [WifiUtil checkNetworkflow];
    if (flowRequestNum == 0) {
        self.lastWifiSentFlow = flow.wifiSentFlowValue;
        flowRequestNum++;
        NSLog(@"第一次流量:%.2f",self.lastWifiSentFlow);
        return;
    }
    float addFlowNumber = flow.wifiSentFlowValue - self.lastWifiSentFlow;
    float addFlowNumberMb = addFlowNumber /1024/1024;
    if (addFlowNumberMb <= 0 ) {
        return;
    }
    NSLog(@"新增流量%.2f",addFlowNumberMb);
    NSDictionary *para = @{@"flowNumber":[NSString stringWithFormat:@"%.2f",addFlowNumberMb],@"userId":[AccountManager shared].user.userId};
    [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, SaveUserFlowAPI) params:para successBlock:^(NSDictionary *returnData) {
        WIFIFlow *flow =  [WifiUtil checkNetworkflow];
        self.lastWifiSentFlow = flow.wifiSentFlowValue;
    } failureBlock:^(NSError *error) {
        
    } showHUD:NO];
    
}

#pragma mark - 更新orgid
- (void)requestOrgId:(NSString *)mac {
    WIFIInfo *info  = [WIFISevice shared].wifiInfo;
    info.bsid = [WifiUtil getWifiMac];
    NSString *mac1 = info.hktMac;
    if (!mac1 || [mac1 isEqualToString:@""] || ![WIFISevice isHKTWifi]) {
        self.wifiInfo.orgId = defaultOrgId;
        return;
    }
    [MHNetworkManager getRequstWithURL:[NSString stringWithFormat:@"http://www.hktfi.com/index.php/Api/ap/getshopinfoBymac/mac/%@",mac1] params:nil successBlock:^(NSDictionary *returnData) {
        NSString *orgId = [returnData objectForKey:@"id"];
        if (orgId && ![orgId isKindOfClass:[NSNull class]] && ![orgId isEqualToString:self.wifiInfo.orgId] ) {
            if (orgId.length > 1) {
                [[NSUserDefaults standardUserDefaults]setObject:orgId forKey:LASTHKTWIFIORGIDKEY];
            }
            
            [WIFISevice shared].wifiInfo.orgId = defaultOrgId;
            
        } else {
            self.wifiInfo.orgId = defaultOrgId;
        }
        if (orgId && ![orgId isKindOfClass:[NSNull class]]) {
            [self getOtTime:orgId];
        } else {
            [self getOtTime:self.wifiInfo.orgId];
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:WIOrgIDChangeNoti object:nil];
  
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
    [[WIFIValidator shared]validator];
    if (self.panelDelegate && [self.panelDelegate respondsToSelector:@selector(handleWhenNetChange:wifiInfo:)]) {
        [self.panelDelegate handleWhenNetChange:[WIFISevice netStatus] wifiInfo:self.wifiCloudInfo];
    }
    
}

- (void)handleWhenUserLogin:(NSNotification *)noti {
    [self startFlowMonitor];
}

- (void)handleWhenUserLogout:(NSNotification *)noti {
    if (self.timer) {
        dispatch_cancel(self.timer);
    }
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
        return WINetFail;
    } else if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusReachableViaWWAN) {
        return WINet4G;
    } else {
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
