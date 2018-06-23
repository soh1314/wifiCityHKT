//
//  WifiManager.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/12.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WifiUtil : NSObject

+(NSString *)getWifiName;
+(NSString *)getWifiMac;
+ (void)fetchSSIDInfo;
+(void)openWifiSetting;
+ (NSString *)getLocalIPAddressForCurrentWiFi;
+ (NSString *)getGprsWifiFlowIOBytes;

@end
