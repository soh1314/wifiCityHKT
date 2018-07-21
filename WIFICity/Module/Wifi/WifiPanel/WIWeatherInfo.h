//
//  WIWeatherInfo.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/25.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WIModel.h"

//"date": "周一 06月25日 (实时：30℃)",
//"dayPictureUrl": "http://api.map.baidu.com/images/weather/day/yin.png",
//"nightPictureUrl": "http://api.map.baidu.com/images/weather/night/leizhenyu.png",
//"weather": "阴转雷阵雨",
//"wind": "东南风微风",
//"temperature": "34 ~ 24℃"

@interface WIWeatherInfo : WIModel

@property (nonatomic,copy)NSString *PM;
@property (nonatomic,copy)NSString *detail;
@property (nonatomic,copy)NSString *date;
@property (nonatomic,copy)NSString *dayPictureUrl;
@property (nonatomic,copy)NSString *nightPictureUrl;
@property (nonatomic,copy)NSString *weather;
@property (nonatomic,copy)NSString *temperature;

@end
