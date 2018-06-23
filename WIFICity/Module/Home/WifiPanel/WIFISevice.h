//
//  WIFISevice.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/15.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WifiNetChangeProtocol.h"
#import "WifiPanelProtocol.h"
#import "WIFICloudInfo.h"

@interface WIFISevice : NSObject<WifiNetChangeProtocol>

+ (instancetype)shared;

@property (nonatomic,strong)WIFICloudInfo *wifiCloudInfo;
@property (nonatomic,strong)dispatch_source_t timer;
@property (nonatomic,weak)id <WifiNetChangeProtocol>delegate;
@property (nonatomic,weak)id <WifiPanelProtocol>panelDelegate;

- (void)setNetMonitor;
+(NSString *)getCurrentWifiName;
+(WINetStatus)netStatus;
+(BOOL)isHKTWifi;

- (void)connectWifi;
- (void)stopWifi;

@end
