//
//  WifiNetChangeProtocol.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/22.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WIFIInfo.h"
@protocol WifiNetChangeProtocol <NSObject>

- (void)handleWhenNetChange:(WINetStatus)status wifiInfo:(WIFIInfo*)info;


@end
