//
//  LoginRegex.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/2.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "LoginRegex.h"

static NSString *const LoginPhoneNilError = @"请输入手机号";
static NSString *const LoginPhoneRegexError = @"请填写正确的手机号";

@implementation LoginRegex

+ (BOOL)checkoutPhoneNum: (NSString *)phoneNum {
    if (!phoneNum || phoneNum.length <= 0) {
        [Dialog simpleToast:LoginPhoneNilError];
        return NO;
    }
    NSString *regexStr = @"^1[3,8]\\d{9}|14[5,7,9]\\d{8}|15[^4]\\d{8}|17[^2,4,9]\\d{8}$";
    NSError *error;
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:&error];
    if (error) return NO;
    NSInteger count = [regular numberOfMatchesInString:phoneNum options:NSMatchingReportCompletion range:NSMakeRange(0, phoneNum.length)];
    if (count > 0) {
        
        return YES;
    } else {
        [Dialog simpleToast:LoginPhoneRegexError];
        return NO;
    }
}

@end
