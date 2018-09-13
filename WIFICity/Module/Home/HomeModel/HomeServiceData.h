//
//  HomeServiceData.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/15.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WIModel.h"

//icon" : "http://192.168.1.103:9091/wifi-city-static/homepage/icon/qjgx.png",
//"name" : "全景高新",
//"type" : 1,
//"url

@interface HomeServiceData : WIModel

//@property (nonatomic,copy)NSString *thirdName;
//@property (nonatomic,copy)NSString *thirdType;
//@property (nonatomic,copy)NSString *thirdImg;
//@property (nonatomic,copy)NSString *thirdSort;
//@property (nonatomic,copy)NSString *thirdUrl;
//@property (nonatomic,copy)NSString *ID;

@property (nonatomic,copy)NSString *icon;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,assign)long type;
@property (nonatomic,copy)NSString *url;
@property (nonatomic,copy)NSString *parameter;
@property (nonatomic,copy)NSArray *children;

@end
