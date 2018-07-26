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
    info.expireTime = [[NSString currentTimeStr]floatValue] + 10 * 60;
    if (![self needValidator:info]) {
        return;
    }
    NSString *wifiIp = [WifiUtil getLocalIPAddressForCurrentWiFi];
    if (!wifiIp) {
        return;
    }
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
    float expireTime = [[NSString unixTimeStamp]floatValue]+20*60;
    NSString *expireStr = [NSString stringWithFormat:@"%.f",expireTime];
    NSLog(@"验证wifi过期时间%@",expireStr);
    NSString *validatorUrl = [NSString stringWithFormat:@"http://%@:2060/wifidog/auth?token=123&mod=1&authway=app&ot=%@",routIP,expireStr];
    [self inerValidateRequest:validatorUrl];
    
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
        NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        if ([str containsString:@"go to internat ok!"]) {
            self.lastHktWifiMac = [WifiUtil getWifiMac];
            [[NSUserDefaults standardUserDefaults]setObject:self.lastHktWifiMac forKey:LASTHKTWIFIMACKEY];
            [[NSNotificationCenter defaultCenter]postNotificationName:WIFIValidatorSuccessNoti object:nil];
            NSLog(@"认证成功");
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"认证网络问题");
        self.validateTime ++;
        if (self.validateTime >= 10) {
            self.validateTime = 0;
        } else {
//             [[NSNotificationCenter defaultCenter]postNotificationName:WIFIValidatorFailNoti object:nil];
        }
       
    }];
   
}

- (void)validatorWhenAppTerminate {
    
}

- (void)backGroundValidator {
    
}

- (BOOL)isHKTWifi {
    NSString *wifiName = [WifiUtil getWifiMac];
    if ([wifiName hasPrefix:@"dc:37"]) {
        return YES;
    } else {
        return NO;
    }
}


@end
