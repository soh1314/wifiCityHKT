//
//  WIUtil.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/7.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WIUtil.h"

@implementation WIUtil

+ (void)callPhone:(NSString *)phoneNumber {
    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@",phoneNumber];
    CGFloat version = [[[UIDevice currentDevice]systemVersion]floatValue];
    if (version >= 10.0) {
        /// 大于等于10.0系统使用此openURL方法
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
    }
    
}

@end
