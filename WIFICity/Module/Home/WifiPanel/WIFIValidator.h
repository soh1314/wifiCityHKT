//
//  WIFIValidator.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/25.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WifiUtil.h"
#import "WIFIValidateInfo.h"
//http://192.168.99.254:2060/wifidog/auth?token=123&mod=1&authway=app&ot=1529894758
@interface WIFIValidator : NSObject

+ (instancetype)shared;

- (BOOL)needValidator:(WIFIValidateInfo *)info;
- (void)validator;

@end
