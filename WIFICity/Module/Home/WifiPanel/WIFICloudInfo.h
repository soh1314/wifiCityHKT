//
//  WIFICloudInfo.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/23.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WIFIInfo.h"

@interface WIFICloudInfo : WIFIInfo

@property (nonatomic,copy)NSString *userId;
@property (nonatomic,assign)NSInteger createDate;
@property (nonatomic,assign)float flowNumber;
@property (nonatomic,assign)float bandWidth;
@property (nonatomic,copy)NSString *ID;

//"userId": "8a2bf9ef63e41f780163ecd5eff101f4",
//"createDate": 1528686877000,
//"flowNumber": 477.0,
//"bandWidth": 10.0,
//"id": "8a2bf9ef63e41f780163ecd69ace01f8"

@end
