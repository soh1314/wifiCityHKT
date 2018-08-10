//
//  WIFIValidator.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/25.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WIFIValidator.h"
#import "WifiValidatorController.h"
#import "WITabBarController.h"
#import "NSString+Additions.h"
#import "WIFISevice.h"
#import "WebViewController.h"
#import "WITabBarController.h"
#import "AppDelegate.h"
#import "CaptivePortalCheck.h"
@interface WIFIValidator()

@property (nonatomic,readwrite,copy)NSString *lastHktWifiMac;
@property (nonatomic,strong)NSMutableArray *validatArray;
@property (nonatomic,assign)NSInteger validateTime;
@property (nonatomic,strong)NSLock *lock;

@end

@implementation WIFIValidator

+ (instancetype)shared {
    static WIFIValidator *manager = nil;
    static dispatch_once_t once_tokn;
    dispatch_once(&once_tokn, ^{
        manager = [[self alloc]init];
        
    });
    return manager;
}

- (id)init {
    if (self = [super init]) {
        self.validatArray = [NSMutableArray array];
       _lastHktWifiMac = [[NSUserDefaults standardUserDefaults]objectForKey:LASTHKTWIFIMACKEY];
    }
    return self;
}

- (BOOL)needValidator:(WIFIValidateInfo *)info {
    BOOL needValidator = YES;
    BOOL existIp = NO;
    for ( int i = 0; i < self.validatArray.count; i++) {
        WIFIValidateInfo *m_info = self.validatArray[i];
        if ([m_info.routIp isEqualToString:info.routIp] && [m_info.wfiiMac isEqualToString:info.wfiiMac]) {
            float timestr = [[NSString unixTimeStamp]floatValue];
            if (timestr > m_info.expireTime ) {
                needValidator = YES;
                [self.validatArray removeObject:m_info];
                [self.validatArray addObject:info];
            } else {
                needValidator = NO;
            }
            existIp = YES;
            break;
        }
    }
    if (!existIp) {
        [self.validatArray addObject:info];
    }
    return needValidator;
}

- (void)validator {
    
    [MBProgressHUD showHUDAddedTo:KWINDOW animated:YES];
    [WIFISevice shared].validating = YES;
    WIFIValidateInfo *info = [WIFIValidateInfo new];
    info.wfiiMac = [WifiUtil getWifiMac];
    info.routIp = [WifiUtil getLocalIPAddressForCurrentWiFi];
    
    info.expireTime = [[NSString unixTimeStamp]integerValue] + 10 * 60;
    if (![self needValidator:info]) {
        [MBProgressHUD hideHUDForView:KWINDOW animated:YES];
        return;
    }
    NSString *wifiIp = [WifiUtil getLocalRoutIpForCurrentWiFi];
    if (!wifiIp || [wifiIp isEqualToString:@""] ) {
        [MBProgressHUD hideAllHUDsForView:KWINDOW animated:YES];
        NSLog(@"wifi ip 为空 无法认证");
        [WIFISevice shared].validating = NO;
        return;
    }
    NSLog(@"当前wifi的IP地址%@",wifiIp);
    NSArray *ipArray = [wifiIp componentsSeparatedByString:@"."];
    NSMutableString *routIP = [NSMutableString string];
    for (int i = 0; i < ipArray.count ; i ++) {
        if (i == ipArray.count - 1) {
            [routIP appendString:@"254"];
        } else if (i == ipArray.count - 2) {
            [routIP appendString:@"99."];
        }
         else {
            [routIP appendString:[NSString stringWithFormat:@"%@.",ipArray[i]]];
        }
    }
    NSInteger expireTime = [[NSString unixTimeStamp]integerValue]+20*60;
    NSString *expireStr = [NSString stringWithFormat:@"%ld",expireTime];
    NSLog(@"验证wifi过期时间%@",expireStr);
    NSString *validatorUrl = [NSString stringWithFormat:@"http://%@:2060/wifidog/auth?token=123&mod=1&authway=app&ot=%@",routIP,expireStr];
    NSLog(@"认证url%@",validatorUrl);
    [[CaptivePortalCheck sharedInstance]checkIsWifiNeedAuthPasswordWithComplection:^(BOOL needAuthPassword) {
        NSLog(@"%d",needAuthPassword);
    } needAlert:YES];
    [self inerValidateRequest:validatorUrl];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"WifiValidateingStatus" object:nil];
//    [self webValidateRequest:validatorUrl];
    
}

- (void)webValidateRequest:(NSString *)url {
    WebViewController *viewController = [WebViewController new];
    viewController.URLString = [url copy];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:viewController];
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    TGTabBarController *tab = delegate.tabBarController;
    
    [tab presentViewController:nav animated:YES completion:nil];
}

- (void)inerValidateRequest:(NSString *)validatorUrl {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    AFSecurityPolicy *policy = [AFSecurityPolicy new];
    [policy setAllowInvalidCertificates:YES];
    manager.securityPolicy = policy;
    NSLog(@"%@",validatorUrl);
    NSString *url = [validatorUrl copy];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:KWINDOW animated:YES];
        NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        [WIFISevice shared].validating = NO;
        if ([str containsString:@"go to internat ok!"]) {
            self.lastHktWifiMac = [WifiUtil getWifiMac];
            [[NSUserDefaults standardUserDefaults]setObject:self.lastHktWifiMac forKey:LASTHKTWIFIMACKEY];
            [[NSNotificationCenter defaultCenter]postNotificationName:WIFIValidatorSuccessNoti object:nil];
            [Dialog simpleToast:@"Wifi认证成功畅享网络"];
            NSLog(@"认证成功");
        } else {
            NSLog(@"认证失败");
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:@"WifiValidateingFinish" object:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"认证网络问题");
        [MBProgressHUD hideHUDForView:KWINDOW animated:YES];
        [WIFISevice shared].validating = NO;
        [[NSNotificationCenter defaultCenter]postNotificationName:WIFIValidatorFailNoti object:nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"WifiValidateingFinish" object:nil];
       
    }];
   
}

- (void)validatorWhenAppTerminate {
    
}

- (void)backGroundValidator {
    
}

- (BOOL)isHKTWifi {
    NSString *wifiName = [WifiUtil getWifiMac];
    if ([wifiName hasPrefix:HKTWIFIMACPREFIX]) {
        return YES;
    } else {
        return NO;
    }
}


@end
