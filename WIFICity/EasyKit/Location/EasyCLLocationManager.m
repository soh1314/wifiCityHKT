//
//  EasyCLLocationManager.m
//  TRGFShop
//
//  Created by yangqing Liu on 2018/1/4.
//  Copyright © 2018年 trgf. All rights reserved.
//

#import "EasyCLLocationManager.h"
#import "NSString+Additions.h"

@implementation EasyCLLocationManager

+ (instancetype)shared {
    static EasyCLLocationManager *manager = nil;
    static dispatch_once_t once_tokn;
    dispatch_once(&once_tokn, ^{
        manager = [[self alloc]init];
    });
    return manager;
}

- (id)init {
    if (self = [super init]) {
        self.location = [WILocation new];
    }
    return self;
}

- (void)requestLocateService {
    int status = [CLLocationManager authorizationStatus];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    if (status < 3) {
        [self.locationManager requestWhenInUseAuthorization];
    }
}

- (void)requestLoateServiceTimeOutLocate:(NSInteger)timeOut complete:(EasyCLLocateComplete)complete {
    int status = [CLLocationManager authorizationStatus];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8)
    {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        [self.locationManager requestWhenInUseAuthorization];
    }
    if (status < 3) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeOut * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            complete(nil,nil,nil,nil);
        });
    } else {
         complete(nil,nil,nil,nil);
    }


}

- (void)startLocate:(EasyCLLocateComplete)complete {
 
    if ([CLLocationManager locationServicesEnabled]) {
        [self.locationManager startUpdatingLocation];
        self.locateCompleteBlock = [complete copy];
    }

}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations API_AVAILABLE(ios(6.0), macos(10.9)) {
    
    CLLocation *newLocation = [locations lastObject];
    self.currentLocation = newLocation;
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    // 反向地理编译出地址信息
    if ([[UIDevice currentDevice].systemVersion floatValue] < 11.0) {
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if (! error) {
                if ([placemarks count] > 0) {
                    CLPlacemark *placemark = [placemarks firstObject];
                    
                    // 获取城市
                    NSString *province = [placemark.administrativeArea copy];
                    NSString *city = placemark.locality;
                    NSString *area = [placemark.subLocality copy];
                    NSString *detailAddress = [placemark.name copy];
                    if (! city) {
                        // 6
                        city = placemark.administrativeArea;
                    }
                    self.location.province = [province copy];
                    NSString *city1 = [city replace:@"市" withString:@""];
                    self.location.city = [city1 copy];
                    self.location.area = [placemark.subLocality copy];
                    self.locateCompleteBlock(province, city, area, detailAddress);
                    [self stopLocate];
                    
                } else if ([placemarks count] == 0) {
                    
                }
            } else {

            }
        }];
    } else {
        [geocoder reverseGeocodeLocation:newLocation preferredLocale:nil completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if (! error) {
                if ([placemarks count] > 0) {
                    CLPlacemark *placemark = [placemarks firstObject];
                    
                    // 获取城市
                    NSString *province = [placemark.administrativeArea copy];
                    NSString *city = placemark.locality;
                    NSString *area = [placemark.subLocality copy];
                    NSString *detailAddress = [placemark.name copy];
                    if (! city) {
                        // 6
                        city = placemark.administrativeArea;
                    }
                    self.location.province = [province copy];
                    NSString *city1 = [city replace:@"市" withString:@""];
                    self.location.city = [city1 copy];
                    self.location.area = [placemark.subLocality copy];
                    self.locateCompleteBlock(province, city, area, detailAddress);
                    [self stopLocate];
                    
                } else if ([placemarks count] == 0) {
                    
                }
            } else {
                
            }
        }];
    }
    
    

}

- (void)stopLocate {
     [self.locationManager stopUpdatingLocation];
}

@end
