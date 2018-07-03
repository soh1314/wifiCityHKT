//
//  WIFIAnnotation.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/3.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import "WIGeometryInfo.h"

@interface WIFIAnnotation : NSObject<BMKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;


@property (nonatomic, strong) WIGeometryInfo *model;

- (NSString *)title;

@end
