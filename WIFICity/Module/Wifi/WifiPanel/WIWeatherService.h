//
//  WIWeatherService.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/25.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WIWeatherInfo.h"

typedef void(^WIWeatherServiceComplete)(WIWeatherInfo *);

@interface WIWeatherService : NSObject

+ (void)getWeatherInfoWithLocation:(NSString *)city complete:(WIWeatherServiceComplete)complete;

@end
