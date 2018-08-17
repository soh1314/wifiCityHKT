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
@property (nonatomic,strong)WIFIValidateInfo *wifi;

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
    WIFIValidateInfo *info = [WIFIValidateInfo new];
    info.wfiiMac = [WifiUtil getWifiMac];
    info.routIp = [WifiUtil getLocalIPAddressForCurrentWiFi];
    self.wifi = info;
    NSLog(@"当前wifi mac 地址 %@",[WIFISevice shared].wifiInfo.bsid);
    NSString *otNumStr = [[NSUserDefaults standardUserDefaults]objectForKey:LASTHKTWIFIORGIDOTTIMEKEY];
    NSInteger otNum;
    if (otNumStr) {
        otNum = [otNumStr integerValue];
    }
    if (otNum > 0) {
         info.expireTime = [[NSString unixTimeStamp]integerValue] + otNum * 60;
    } else {
         info.expireTime = [[NSString unixTimeStamp]integerValue] + 30 * 60;
    }
   
    if (![self needValidator:info] && !self.reconnect )  {
        [MBProgressHUD hideHUDForView:KWINDOW animated:YES];
        return;
    }
    self.reconnect = NO;
    NSString *routerIp = [WifiUtil routerIp];
    if (! routerIp || [routerIp isEqualToString:@""] ) {
        [MBProgressHUD hideAllHUDsForView:KWINDOW animated:YES];
        NSLog(@"wifi ip 为空 无法认证");
        [WIFISevice shared].validating = NO;
        return;
    }
    NSLog(@"当前wifi的路由器IP地址%@",routerIp);
    NSInteger expireTime;
    if (otNum > 0) {
        expireTime = [[NSString unixTimeStamp]integerValue]+otNum*60;
    } else {
        expireTime = [[NSString unixTimeStamp]integerValue]+30*60;
    }
    
    NSString *expireStr = [NSString stringWithFormat:@"%ld",expireTime];
    NSLog(@"验证wifi过期时间%@",expireStr);
    NSString *validatorUrl = [NSString stringWithFormat:@"http://%@:2060/wifidog/auth?token=123&mod=1&authway=app&ot=%@",routerIp,expireStr];
    if (![validatorUrl contains:@"192"]) {
        return;
    }
    NSLog(@"认证url%@",validatorUrl);
//    [[CaptivePortalCheck sharedInstance]checkIsWifiNeedAuthPasswordWithComplection:^(BOOL needAuthPassword) {
//        NSLog(@"%d",needAuthPassword);
//    } needAlert:NO];
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
    NSString *url = [validatorUrl copy];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:KWINDOW animated:YES];
        NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        if ([str containsString:@"go to internat ok!"] ) {
            self.lastHktWifiMac = [WifiUtil getWifiMac];
            self.wifi.validated = YES;
            [[NSUserDefaults standardUserDefaults]setObject:self.lastHktWifiMac forKey:LASTHKTWIFIMACKEY];
            [[NSNotificationCenter defaultCenter]postNotificationName:WIFIValidatorSuccessNoti object:nil];
//            [Dialog simpleToast:@"Wifi认证成功畅享网络"];
            NSLog(@"认证成功");
        } else {
            NSLog(@"认证失败");
        }
        [self checkAppleConnect];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"WifiValidateingFinish" object:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"认证网络问题");
        [MBProgressHUD hideHUDForView:KWINDOW animated:YES];
        [[NSNotificationCenter defaultCenter]postNotificationName:WIFIValidatorFailNoti object:nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"WifiValidateingFinish" object:nil];
       
    }];
   
}

- (void)checkAppleConnect {
    [[CaptivePortalCheck sharedInstance]checkIsWifiNeedAuthPasswordWithComplection:^(BOOL needAuthPassword) {
        NSLog(@"需不需要进行认证%d",needAuthPassword);
    } needAlert:NO];
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
