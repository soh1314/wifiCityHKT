//
//  WIFIInfo.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/15.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WIModel.h"

@interface WIFIInfo : WIModel

@property (nonatomic,copy)NSString *sid;
@property (nonatomic,copy)NSString *bsid;
@property (nonatomic,copy)NSString *IP;
@property (nonatomic,copy)NSString *routeIP;

@property (nonatomic,copy)NSString *signalStrength;
@property (nonatomic,copy)NSString *orgId;
@property (nonatomic,copy)NSString *endTime;

@end
