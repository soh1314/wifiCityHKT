//
//  WIFIFlow.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/25.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WIModel.h"

@interface WIFIFlow : WIModel

@property (nonatomic,copy)NSString* wwanReceived;
@property (nonatomic,copy)NSString* wifiSent;
@property (nonatomic,copy)NSString* wifiReceived;
@property (nonatomic,copy)NSString* wwanSent;

@end
