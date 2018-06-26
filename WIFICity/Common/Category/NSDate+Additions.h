//
//  NSDate+Additions.h
//  TRGFShop
//
//  Created by yangqing Liu on 2017/9/27.
//  Copyright © 2017年 trgf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Additions)

+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;

+ (NSDate *)dateWithString:(NSString *)string;
+ (NSDate *)dateWithString2:(NSString *)string;
+ (NSString *)minute15DistantWithStrng:(NSString *)string;
+ (NSString *)day15DistantWithStrng:(NSString *)string;
+ (NSTimeInterval)currentDistant:(NSString *)pastDate;

@end
