//
//  NetErrorHandle.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/14.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "NetErrorHandle.h"

@implementation NetErrorHandle

+ (void)handleResponse:(WINetResponse *)response {
    if (response && response.msg && !response.success) {
        [Dialog simpleToast:response.msg];
    }
    
}

+ (void)handle404NetResponse {
    kHudNetError;
}

@end
