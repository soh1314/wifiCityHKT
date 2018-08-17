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
@property (nonatomic,strong)WIFIInfo *wifiInfo;
@property (nonatomic,strong)dispatch_source_t timer;
@property (nonatomic,weak)id <WifiNetChangeProtocol>delegate;
@property (nonatomic,weak)id <WifiPanelProtocol>panelDelegate;
@property (nonatomic,copy)NSString *orgID;
@property (nonatomic,assign)BOOL recoveryNet;
@property (nonatomic,strong)NSMutableArray *hktWifiArray;
@property (nonatomic,strong)NSMutableArray *otherWifiArray;
@property (nonatomic,assign)BOOL validating;

- (void)setNetMonitor;
+(WINetStatus)netStatus;
+(BOOL)isHKTWifi;
- (void)connectWifi;
- (void)stopWifi;
- (void)scanWifiList;
- (void)applicationConnectWifi:(WIFIInfo *)info;
- (void)requestOrgId:(NSString *)mac;

@end
