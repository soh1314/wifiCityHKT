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
#import <WebKit/WebKit.h>
#import "WIFIPusher.h"
#import "EasyAllertUtil.h"
#import "NSString+Additions.h"
static NSInteger defaultOt = 60*60*24;
@interface WIFIValidator()

@property (nonatomic,readwrite,copy)NSString *lastHktWifiMac;
@property (nonatomic,strong)NSMutableArray *validatArray;
@property (nonatomic,assign)NSInteger validateTime;
@property (nonatomic,strong)NSLock *lock;
@property (nonatomic,strong)WIFIValidateInfo *wifiInfo;
@property (nonatomic,strong)WKWebView *webview;
@property (nonatomic,strong)UIAlertController *allertCtrl;

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
    }
    return self;
}

- (BOOL)needValidator:(WIFIValidateInfo *)info {
    BOOL needValidator = YES;
    BOOL existIp = NO;
    for ( int i = 0; i < self.validatArray.count; i++) {
        WIFIValidateInfo *m_info = self.validatArray[i];
        if ([m_info.routIp isEqualToString:info.routIp] && [m_info.wfiiMac isEqualToString:info.wfiiMac]) {
             NSInteger timestr = [[NSString unixTimeStamp]integerValue];
            if (timestr > m_info.expireTime - 300) {
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
    self.wifiInfo = info;
    if (self.resetExpireTime) {
        [self sendValidateRequest];
    } else {
        if (![WIFISevice isHKTWifi] && !self.reconnect) {
            [MBProgressHUD hideAllHUDsForView:KWINDOW animated:YES];
            return;
        }
        NSString *otNumStr = [[NSUserDefaults standardUserDefaults]objectForKey:LastWiFiOrgID_OutTime_Key];
        NSInteger otNum = [otNumStr integerValue];;
        info.expireTime = otNum > 0 ?  [[NSString unixTimeStamp]integerValue] + otNum * 60 : [[NSString unixTimeStamp]integerValue] + defaultOt;
        if (![self needValidator:info] && !self.reconnect && [WIFISevice shared].wifiInfo.validated)  {
            [MBProgressHUD hideAllHUDsForView:KWINDOW animated:YES];
            return;
        }
        NSString *routerIp = [WifiUtil routerIp];
        if ([routerIp isNilString] ) {
            [MBProgressHUD hideAllHUDsForView:KWINDOW animated:YES];
            NSLog(@"wifi ip 为空 无法认证");
            return;
        }
        
        self.reconnect = NO;
        [self sendValidateRequest];
    }

}

- (void)sendValidateRequest {
    NSString *routerIp = [WifiUtil routerIp];
    NSString *expireStr = [NSString stringWithFormat:@"%ld",self.wifiInfo.expireTime];
    routerIp = @"192.168.99.254";
    NSString *validatorUrl = [NSString stringWithFormat:@"http://192.168.99.254:2060/wifidog/auth?token=123&authway=temp&ot=%@",expireStr];
    NSString *validatorUrlEncode = [validatorUrl hanziURLEncode];
    NSLog(@"当前wifi的路由器IP地址%@",routerIp);
    NSLog(@"认证url%@",validatorUrl);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self inerValidateRequest:validatorUrlEncode];
    });
    [[NSNotificationCenter defaultCenter]postNotificationName:@"WifiValidateingStatus" object:nil];
}

- (void)inerValidateRequest:(NSString *)validatorUrl {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    AFSecurityPolicy *policy = [AFSecurityPolicy new];
    [policy setAllowInvalidCertificates:YES];
    manager.securityPolicy = policy;
    NSString *url = [validatorUrl copy];
    if (![url contains:@"192"]) {
        [MBProgressHUD hideAllHUDsForView:KWINDOW animated:YES];
        return;
    }
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideAllHUDsForView:KWINDOW animated:YES];
        NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        if ([str containsString:@"go to internat ok!"] ) {
            self.lastHktWifiMac = [WifiUtil getWifiMac];
            [WIFISevice shared].wifiInfo.validated = YES;
            [WIFIPusher sendWifiExpiredPush:self.wifiInfo.wfiiMac];
            [[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithInteger:self.wifiInfo.expireTime] forKey:self.wifiInfo.wfiiMac];
            [[NSNotificationCenter defaultCenter]postNotificationName:WIFIValidatorSuccessNoti object:nil];
            NSLog(@"认证成功");
            if (self.allertCtrl) {
                [self.allertCtrl dismissViewControllerAnimated:YES completion:nil];
            }
            if (!self.resetExpireTime) {
                [Dialog simpleToast:@"认证成功"];
            } else {
                self.resetExpireTime = NO;
            }
            
        } else {
            NSLog(@"认证失败");
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:@"WifiValidateingFinish" object:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"认证网络问题");
        [WIFISevice shared].wifiInfo.validated = NO;
       UIAlertController *allert =  [EasyAllertUtil presentAlertViewWithTitle:@"华宽通WiFi" message:@"当前网络繁忙认证失败,是否重新认证" cancelTitle:@"取消" defaultTitle:@"确定" distinct:YES cancel:^{
            
        } confirm:^{
            [self validator];
            self.reconnect = YES;
        }];
        self.allertCtrl = allert;
        [MBProgressHUD hideAllHUDsForView:KWINDOW animated:YES];
        [[NSNotificationCenter defaultCenter]postNotificationName:WIFIValidatorFailNoti object:nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"WifiValidateingFinish" object:nil];
    }];
}

- (void)checkAppleConnect {
    [[CaptivePortalCheck sharedInstance]checkIsWifiNeedAuthPasswordWithComplection:^(BOOL needAuthPassword) {
        NSLog(@"需不需要进行认证%d",needAuthPassword);
    } needAlert:NO];
}



@end
