//
//  NSDictionary+utils.m
//  TRGFShop
//
//  Created by yangqing Liu on 2017/9/24.
//  Copyright © 2017年 trgf. All rights reserved.
//

#import "NSDictionary+utils.h"
#import "NSString+Additions.h"
#import "GTMBase64.h"
@implementation NSDictionary (utils)

- (NSString *)bse64UrlEncode {
    NSData *jsonStr = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    NSString *tem = [[NSString alloc]initWithData:jsonStr encoding:NSUTF8StringEncoding];
    NSString *encodeJsonStr = [tem URLEncode];
    NSString *base64Str  = [GTMBase64 encodeBase64String:encodeJsonStr];
    return base64Str;
}

@end
