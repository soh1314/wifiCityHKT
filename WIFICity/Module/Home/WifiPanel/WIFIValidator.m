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

@interface WIFIValidator()


@property (nonatomic,strong)NSMutableArray *validatArray;

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
        if ([m_info.routIp isEqualToString:info.routIp]) {
            float timestr = [[NSString currentTimeStr]floatValue];
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
    
    WIFIValidateInfo *info = [WIFIValidateInfo new];
    info.routIp = [WifiUtil getLocalIPAddressForCurrentWiFi];
    info.expireTime = [[NSString currentTimeStr]floatValue] + 30 * 60;
    if (![self needValidator:info]) {
        return;
    }
    NSString *wifiIp = [WifiUtil getLocalIPAddressForCurrentWiFi];
    NSLog(@"当前wifi的IP地址%@",wifiIp);
    NSArray *ipArray = [wifiIp componentsSeparatedByString:@"."];
    NSMutableString *routIP = [NSMutableString string];
    for (int i = 0; i < ipArray.count ; i ++) {
        if (i == ipArray.count - 1) {
            [routIP appendString:@"254"];
        } else {
            [routIP appendString:[NSString stringWithFormat:@"%@.",ipArray[i]]];
        }
    }
    float expireTime = [[NSString unixTimeStamp]floatValue]+30*60;
    NSString *expireStr = [NSString stringWithFormat:@"%.f",expireTime];
    NSLog(@"验证wifi过期时间%@",expireStr);
    NSString *validatorUrl = [NSString stringWithFormat:@"http://%@:2060/wifidog/auth?token=123&mod=1&authway=app&ot=%@",routIP,expireStr];
    WifiValidatorController *vc = [[WifiValidatorController alloc]init];
    vc.URLString = [validatorUrl copy];
    UIViewController *root = [UIApplication sharedApplication].delegate.window.rootViewController;
    if (root && [root isKindOfClass:[TGTabBarController class]]) {
        TGTabBarController *tabbarController = (TGTabBarController*)root;
        UIViewController *selectVc =  tabbarController.selectedViewController;
        if ([selectVc isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)selectVc;
            [nav pushViewController:vc animated:YES];
        }
    }
    
}

@end
