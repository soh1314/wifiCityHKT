//
//  NSDate+Additions.m
//  TRGFShop
//
//  Created by yangqing Liu on 2017/9/27.
//  Copyright © 2017年 trgf. All rights reserved.
//

#import "NSDate+Additions.h"

@implementation NSDate (Additions)

+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        return 1;
    }
    else if (result == NSOrderedAscending){
        return -1;
    }
    return 0;
    
}

+ (NSDate *)dateWithString:(NSString *)string {
 
    // 日期格式化类
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    // 设置日期格式 为了转换成功
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // NSString * -> NSDate *
        NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
        [format setTimeZone:timeZone];
    
    NSDate *date = [format dateFromString:string];
    return date;
    
//    NSString *newString = [format stringFromDate:data];
    
}

+ (NSDate *)dateWithString2:(NSString *)string {
    
    // 日期格式化类
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    // 设置日期格式 为了转换成功
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // NSString * -> NSDate *
    //        NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    //        [format setTimeZone:timeZone];
    
    NSDate *date = [format dateFromString:string];
    return date;
    
    //    NSString *newString = [format stringFromDate:data];
    
}

+ (NSString *)day15DistantWithStrng:(NSString *)string {
    NSDate *nowdate = [self dateWithString:string];
    NSDate *theDate = [[NSDate alloc]initWithTimeInterval:24*60*60*15 sinceDate:nowdate];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *newString = [format stringFromDate:theDate];
    return newString;
}

+ (NSString *)minute15DistantWithStrng:(NSString *)string {
    NSDate *nowdate = [self dateWithString:string];
    NSDate *theDate = [[NSDate alloc]initWithTimeInterval:15*60 sinceDate:nowdate];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *newString = [format stringFromDate:theDate];
    return newString;
}

+ (NSTimeInterval)currentDistant:(NSString *)pastDate {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
//    [format setTimeZone:timeZone];    
     NSDate *someDayDate = [format dateFromString:pastDate];
     NSDate *currentDate = [NSDate date];
    
    NSTimeInterval start = [currentDate timeIntervalSince1970]*1;
    NSTimeInterval end = [someDayDate timeIntervalSince1970]*1;
    NSTimeInterval value = end - start-8*60*60;
    return value;
    
}

@end
