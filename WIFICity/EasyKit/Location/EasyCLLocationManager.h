//
//  EasyCLLocationManager.h
//  TRGFShop
//
//  Created by yangqing Liu on 2018/1/4.
//  Copyright © 2018年 trgf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
typedef void(^EasyCLLocateComplete)(NSString *province,NSString *city,NSString *area,NSString *detailAddress);

@interface EasyCLLocationManager : NSObject

+ (instancetype)shared;

@property (nonatomic,strong)CLLocationManager *locationManager;

@property (nonatomic,strong)CLLocation *currentLocation;

@property (nonatomic,copy)EasyCLLocateComplete locateCompleteBlock;

- (void)requestLocateService;

- (void)requestLoateServiceTimeOutLocate:(NSInteger)timeOut complete:(EasyCLLocateComplete)complete;

- (void)startLocate:(EasyCLLocateComplete)complete;

- (void)stopLocate;

@end
