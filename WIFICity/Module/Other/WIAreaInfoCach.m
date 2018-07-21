//
//  WIAreaInfoCach.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/29.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WIAreaInfoCach.h"

@implementation WIAreaInfoCach

+ (NSDictionary *)homeAreaCach {
   NSDictionary *dic = [EasyCacheHelper getFileWithKey:HOMEAPSERVICEKEY];
    return dic;
}

+(void)cachHomeAeraInfo:(NSDictionary *)dic {
    [EasyCacheHelper saveResponseCache:dic forKey:HOMEAPSERVICEKEY];
}


@end
