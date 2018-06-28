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
        self.delegate = self;
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
        WIFIFlow *flow =  [WifiUtil checkNetworkflow];
        self.wifiCloudInfo.flowNumber =  [flow.wifiSent floatValue];
        if (self.panelDelegate && [self.panelDelegate respondsToSelector:@selector(wifiPanelRefreshWifiInfo:)]) {
            [self.panelDelegate wifiPanelRefreshWifiInfo:self.wifiCloudInfo];
        }
        self.lastWifiSentFlow = self.wifiCloudInfo.flowNumber;
        
    } failureBlock:^(NSError *error) {
        
    } showHUD:NO];
}

- (void)saveUserFlow {
    NSDictionary *para = @{@"flowNumber":@"0",@"userId":[AccountManager shared].user.userId};
    [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, SaveUserFlowAPI) params:para successBlock:^(NSDictionary *returnData) {
        
    } failureBlock:^(NSError *error) {
        
    } showHUD:NO];
    
}

#pragma mark - notification

- (void)wiApplicationWillEnterForeground:(NSNotification *)noti {
    NSString *wifiMac = [WIFISevice getCurrentWifiMac];
    if (wifiMac &&![self.currentWifiMac isEqualToString:wifiMac]) {
        if ([WIFISevice isHKTWifi] ) {
            [[WIFIValidator shared]validator];
        }
    }
    [self handleWhenNetChange:WINetWifi];
    if (self.panelDelegate && [self.panelDelegate respondsToSelector:@selector(handleWhenNetChange:wifiInfo:)]) {
        [self.panelDelegate handleWhenNetChange:WINetWifi wifiInfo:self.wifiCloudInfo];
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

+(NSString *)getCurrentWifiMac {
    NSString *wifiName = nil;
    
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    if (!wifiInterfaces) {
        return @"未知";
    }
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    
    for (NSString *interfaceName in interfaces) {
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        if (dictRef) {
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
            wifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeyBSSID];
            CFRelease(dictRef);
        }
    }
    
    CFRelease(wifiInterfaces);
    return wifiName;
}

+(BOOL)isHKTWifi {
    NSString *wifiName = [self getCurrentWifiMac];
    if ([wifiName hasPrefix:@"dc:37:d2"]) {
        return YES;
    } else {
        return NO;
    }
}

@end
