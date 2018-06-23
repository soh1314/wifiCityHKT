//
//  WifiPanelProtocol.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/23.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WIFIInfo.h"

@protocol WifiPanelProtocol <NSObject>

- (void)wifiPanelRefreshWifiInfo:(WIFIInfo *)info;
- (void)handleWhenNetChange:(WINetStatus)status wifiInfo:(WIFIInfo*)info;

@end
