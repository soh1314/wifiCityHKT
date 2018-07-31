//
//  WIComment.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/31.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WIComment.h"

@implementation WIComment

+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id":@"ID"}];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

@end
