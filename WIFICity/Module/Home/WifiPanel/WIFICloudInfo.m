//
//  WIFICloudInfo.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/23.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WIFICloudInfo.h"

@implementation WIFICloudInfo

+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id":@"ID"}];
}


@end
