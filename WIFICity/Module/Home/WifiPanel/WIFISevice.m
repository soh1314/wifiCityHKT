//
//  WIFISevice.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/15.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WIFISevice.h"
#import<SystemConfiguration/CaptiveNetwork.h>
#import "NSString+Additions.h"
#import "WifiUtil.h"
#import "WIFIValidator.h"
#import <AFNetworking/AFNetworking.h>

static NSInteger flowRequestNum = 0;

@interface WIFISevice()

@property (nonatomic,assign)WINetStatus net_status;
@property (nonatomic,assign)float lastWifiSentFlow;
@property (nonatomic,assign)BOOL validateSuccess;
@property (nonatomic,copy)NSString *currentWifiMac;

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
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleWhenUserLogout:) name:WILogoutSuccessNoti object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleWhenUserLogin:) name:WILoginSuccessNoti object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(wiApplicationWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(validateSuccess:) name:WIFIValidatorSuccessNoti object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(validateFail:) name:WIFIValidatorFailNoti object:nil];
        
        self.delegate = self;
        self.wifiInfo = [WIFIInfo new];
        NSString *cachOrgId = [[NSUserDefaults standardUserDefaults]objectForKey:LASTHKTWIFIORGIDKEY];
        if (cachOrgId) {
             self.wifiInfo.orgId = [cachOrgId copy];
        } else {
            self.wifiInfo.orgId = @"8a8ab0b246dc81120146dc8180ba0017";
        }
    }
    return self;
}


//定时流量监测
- (void)startFlowMonitor {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    self.timer = _timer;
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),30.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        if ([AccountManager shared].user.userId) {
            [self findUserFLow];
            [self saveUserFlow];
        }
    });
    dispatch_resume(self.timer);
}

- (void)setNetMonitor {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"%ld",status);
        if (status == AFNetworkReachabilityStatusNotReachable || status == AFNetworkReachabilityStatusUnknown) {
            self.net_status = WINetFail;
           
        } else if ( status == AFNetworkReachabilityStatusReachableViaWWAN ) {
            self.net_status = WINet4G;
        }
        else {
            self.net_status = WINetWifi;
            self.currentWifiMac = [WifiUtil getWifiMac];
            self.wifiInfo.sid = [WifiUtil getWifiName];
            self.wifiInfo.bsid = [self.currentWifiMac copy];
            
            if ([WIFISevice isHKTWifi] ) {
                [[WIFIValidator shared]validator];
            }
        }
        NSLog(@"wifi status : %ld",self.net_status);
        [self handleWhenNetChange:self.net_status];
        if (self.panelDelegate && [self.panelDelegate respondsToSelector:@selector(handleWhenNetChange:wifiInfo:)]) {
            [self.panelDelegate handleWhenNetChange:self.net_status wifiInfo:self.wifiCloudInfo];
        }
        
    }];
    [manager startMonitoring];
}

#pragma mark - 上传下载用户最新流量
- (void)findUserFLow {
    NSDictionary *para = @{@"userId":[AccountManager shared].user.userId};
    [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, FindUserFLowAPI) params:para successBlock:^(NSDictionary *returnData) {
        self.wifiCloudInfo = [[WIFICloudInfo alloc]initWithDictionary:[returnData objectForKey:@"obj"] error:nil];
//        self.wifiCloudInfo.flowNumber =  [flow.wifiSent floatValue];
        if (self.panelDelegate && [self.panelDelegate respondsToSelector:@selector(wifiPanelRefreshWifiInfo:)]) {
            [self.panelDelegate wifiPanelRefreshWifiInfo:self.wifiCloudInfo];
        }
        
        
    } failureBlock:^(NSError *error) {
        
    } showHUD:NO];
}

- (void)saveUserFlow {
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
    NSLog(@"认证失败了");
    [[WIFIValidator shared]validator];
}

- (void)wiApplicationWillEnterForeground:(NSNotification *)noti {
    NSString *wifiMac = [WifiUtil getWifiMac];
    self.wifiInfo.sid = [WifiUtil getWifiName];
    self.wifiInfo.bsid = [wifiMac copy];
//    if (wifiMac &&![self.currentWifiMac isEqualToString:wifiMac]) {
//
//    }
    if ([WIFISevice isHKTWifi] ) {
        [[WIFIValidator shared]validator];
    }
    [self handleWhenNetChange:[WIFISevice netStatus]];
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
        return WINetFail;
    } else if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusReachableViaWWAN) {
        return WINet4G;
    } else {
        return WINetWifi;
    }
    
}

+(BOOL)isHKTWifi {
    NSString *wifiName = [WifiUtil getWifiMac];
    if ([wifiName hasPrefix:@"dc:37"]) {
        return YES;
    } else {
        return NO;
    }
}

@end
