//
//  WIFIValidateInfo.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/25.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WIModel.h"

@interface WIFIValidateInfo : WIModel

@property (nonatomic,copy)NSString *routIp;
@property (nonatomic,copy)NSString *wfiiMac;
@property (nonatomic,assign)NSInteger expireTime;
@property (nonatomic,assign)BOOL validated;

@end
