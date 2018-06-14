//
//  WIUser.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/12.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WIUser.h"

@implementation WIUser



+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id":@"userId"}];
}


@end
