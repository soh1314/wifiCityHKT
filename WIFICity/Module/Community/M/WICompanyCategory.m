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
    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:@{@"id":@"ID"}];
}

@end
