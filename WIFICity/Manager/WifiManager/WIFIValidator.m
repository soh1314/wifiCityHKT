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
static NSInteger defaultOt = 30 * 60;
@interface WIFIValidator()

@property (nonatomic,readwrite,copy)NSString *lastHktWifiMac;
@property (nonatomic,strong)NSMutableArray *validatArray;
@property (nonatomic,assign)NSInteger validateTime;
@property (nonatomic,strong)NSLock *lock;
@property (nonatomic,strong)WIFIValidateInfo *wifi;
@property (nonatomic,strong)WKWebView *webview;

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
    self.wifi = info;
    if (![WIFISevice isHKTWifi]) {
        [MBProgressHUD hideHUDForView:KWINDOW animated:YES];
        return;
    }
    NSLog(@"当前wifi mac 地址 %@",[WIFISevice shared].wifiInfo.bsid);
    NSString *otNumStr = [[NSUserDefaults standardUserDefaults]objectForKey:LASTHKTWIFIORGIDOTTIMEKEY];
    NSInteger otNum;
    if (otNumStr) {
        otNum = [otNumStr integerValue];
    }
    if (otNum > 0) {
         info.expireTime = [[NSString unixTimeStamp]integerValue] + otNum * 60;
    } else {
         info.expireTime = [[NSString unixTimeStamp]integerValue] + defaultOt;
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
        expireTime = [[NSString unixTimeStamp]integerValue]+defaultOt*60;
    }
    
    NSString *expireStr = [NSString stringWithFormat:@"%ld",expireTime];
//    if (![routerIp contains:@"192"] ) {
        routerIp = @"192.168.99.254";
//    }
    NSString *validatorUrl = [NSString stringWithFormat:@"http://%@:2060/wifidog/auth?token=123&mod=1&authway=app&ot=%@",routerIp,expireStr];

    NSLog(@"认证url%@",validatorUrl);
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([WIFISevice netStatus] == WINetWifi) {
            sleep(1);
            [self inerValidateRequest:validatorUrl];
        }
    });
    
//    [self loadwebview:validatorUrl];
//    [self webValidateRequest:validatorUrl];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"WifiValidateingStatus" object:nil];
    
}

- (void)loadwebview:(NSString *)urlstr {
    WKWebView *webview = [WKWebView new];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
    webview.frame = CGRectZero;
    self.webview = webview;
     [webview loadRequest:request];
    webview.navigationDelegate = self;

}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
    NSLog(@"%@",navigationAction.request.URL);
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
//            [WIFIPusher sendWIFINoti];
            NSLog(@"认证成功");
            [Dialog simpleToast:@"认证成功"];
        } else {
            [Dialog simpleToast:@"认证失败"];
            NSLog(@"认证失败");
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:@"WifiValidateingFinish" object:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"认证网络问题");
        [EasyAllertUtil presentAlertViewWithTitle:@"华宽通WiFi" message:@"当前网络繁忙认证失败,是否重新认证" cancelTitle:@"取消" defaultTitle:@"确定" distinct:YES cancel:^{
            
        } confirm:^{
            [self validator];
        }];
        [Dialog simpleToast:@"认证失败"];
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
