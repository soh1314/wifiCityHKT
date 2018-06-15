//
//  WIQQInfo.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/15.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WIModel.h"
//{
//    city = "";
//    figureurl = "http://qzapp.qlogo.cn/qzapp/1106178641/C52CC8822256DC2503492E9888FDF814/30";
//    "figureurl_1" = "http://qzapp.qlogo.cn/qzapp/1106178641/C52CC8822256DC2503492E9888FDF814/50";
//    "figureurl_2" = "http://qzapp.qlogo.cn/qzapp/1106178641/C52CC8822256DC2503492E9888FDF814/100";
//    "figureurl_qq_1" = "http://thirdqq.qlogo.cn/qqapp/1106178641/C52CC8822256DC2503492E9888FDF814/40";
//    "figureurl_qq_2" = "http://thirdqq.qlogo.cn/qqapp/1106178641/C52CC8822256DC2503492E9888FDF814/100";
//    gender = "\U7537";
//    "is_lost" = 0;
//    "is_yellow_vip" = 0;
//    "is_yellow_year_vip" = 0;
//    level = 0;
//    msg = "";
//    nickname = "Liusanity said\Uff0cl";
//    province = "";
//    ret = 0;
//    vip = 0;
//    year = 2017;
//    "yellow_vip_level" = 0;
//}
@interface WIQQInfo : WIModel

@property (nonatomic,copy)NSString *uid;
@property (nonatomic,copy)NSString *city;
@property (nonatomic,copy)NSString *gender;
@property (nonatomic,copy)NSString *figureurl;
@property (nonatomic,copy)NSString *figureurl_qq_1;
@property (nonatomic,assign)BOOL is_lost;
@property (nonatomic,copy)NSString *nickname;
@property (nonatomic,copy)NSString *province;
@property (nonatomic,copy)NSString *year;

@end
