//
//  WICompanyCategory.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/7.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WICompanyCategory.h"

@implementation WICompanyCategory

+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id":@"ID"}];
}

- (NSString *)industryImgUrl {
    NSString *url = [NSString stringWithFormat:@"%@/%@",kUrlHost,self.industryImg];
    NSString *urlEncode = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [urlEncode copy];
}

@end
