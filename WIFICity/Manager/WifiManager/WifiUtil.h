//
//  WifiManager.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/12.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WIFIFlow.h"
@interface WifiUtil : NSObject

+(NSString *)getWifiName;
+(NSString *)getWifiMac;
+(NSString *)getRegularMac;
+ (void)fetchSSIDInfo;
+(void)openWifiSetting;
+ (NSString *)getLocalIPAddressForCurrentWiFi;
+ (NSString *)getGprsWifiFlowIOBytes;
+(void)autoConnectWifi;
+ (WIFIFlow *)checkNetworkflow;
+ (NSString *)getLocalRoutIpForCurrentWiFi;
+ (void)registerNetwork:(NSString *)ssid;
+ (NSString *) routerIp;

@end
