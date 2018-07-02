//
//  WIAreaInfoCach.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/29.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EasyCacheHelper.h"
@interface WIAreaInfoCach : NSObject

+ (NSDictionary *)homeAreaCach;
+(void)cachHomeAeraInfo:(NSDictionary *)dic;

@end
