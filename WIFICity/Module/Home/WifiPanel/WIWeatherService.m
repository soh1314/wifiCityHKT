//
//  WIWeatherService.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/25.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WIWeatherService.h"
#import "NSString+Additions.h"
static NSString *const BaiduWeatherAPI = @"http://api.map.baidu.com/telematics/v3/weather";
//,@"mcode":@"EE:0C:C8:50:54:53:96:5A:55:8C:23:2F:93:7E:EB:AE:D8:C8:1B:F1;com.example.tangdekun.androidannotationsdemo"


@implementation WIWeatherService


+ (void)getWeatherInfoWithLocation:(NSString *)city complete:(WIWeatherServiceComplete)complete{
    
    NSDictionary *dic = @{@"ak":@"6tYzTvGZSOpYB5Oc2YGGOKt8",@"location":city,@"output":@"json"};
    [MHNetworkManager getRequstWithURL:BaiduWeatherAPI params:dic successBlock:^(NSDictionary *returnData) {
        NSString *status = [returnData objectForKey:@"status"];
        if (status && [status isKindOfClass:[NSString class]]&& [status isEqualToString:@"success"]) {
            NSArray *results = [returnData objectForKey:@"results"];
            NSDictionary *firstReuslt = nil;
            if (results && [results isKindOfClass:[NSArray class]] && results.count > 0) {
                firstReuslt = results[0];
            }
            NSString *pm = [firstReuslt objectForKey:@"pm25"];

            NSArray *weekWeatherArray = [firstReuslt objectForKey:@"weather_data"];
            if (weekWeatherArray && [weekWeatherArray isKindOfClass:[NSArray class]] && weekWeatherArray.count > 0) {
                NSDictionary *weatherInfo = weekWeatherArray[0];
                if (weatherInfo && [weatherInfo isKindOfClass:[NSDictionary class]]) {
                    WIWeatherInfo *info = [[WIWeatherInfo alloc]initWithDictionary:weatherInfo error:nil];
                    if (pm && [pm isKindOfClass:[NSString class]]) {
                        info.PM = [pm copy];
                        complete(info);
                    }
                }
            }
        }
    } failureBlock:^(NSError *error) {
         complete(nil);
    } showHUD:NO];
}

@end
