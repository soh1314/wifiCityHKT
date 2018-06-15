//
//  NetErrorHandle.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/14.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WINetResponse.h"

@interface NetErrorHandle : NSObject

+ (void)handleResponse:(WINetResponse *)response;

+ (void)handle404NetResponse;

@end
