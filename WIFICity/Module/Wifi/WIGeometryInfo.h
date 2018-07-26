//
//  WIGeometryInfo.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/3.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WIModel.h"

@interface WIGeometryInfo : WIModel

@property (nonatomic,copy) NSString * longitude;
@property (nonatomic,copy) NSString * latitude;

@property (nonatomic,copy) NSString * mac;
@property (nonatomic,copy) NSString * wifiName;
@property (nonatomic,copy) NSString * distance;
@property (nonatomic,copy) NSString * gw_id;

@end
