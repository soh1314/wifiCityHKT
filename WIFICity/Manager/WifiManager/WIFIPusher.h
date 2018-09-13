//
//  WIFIPusher.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/20.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WIFIPusher : NSObject

+ (void)requestAuthor;
+ (void)sendWifiExpiredPush:(NSString *)wifiMac;
+ (void)sendRegionPush;
+ (void)availabel8SendExpireValidatePush:(NSInteger)outTimeNumber;

@end
