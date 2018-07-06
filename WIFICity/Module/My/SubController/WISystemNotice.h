//
//  WISystemNotice.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/4.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WIModel.h"

@interface WISystemNotice : WIModel
//"abstracts": "增加“设备管理”功能，方便安装人员维护",
//"details": "增加“设备管理”功能，方便安装人员维护",
//"dates": 1511854276000,
//"id": "8a2bf9ef5fb91eee01600188e3140282",
//"title": "【产品公告】"

@property (nonatomic,copy)NSString *abstracts;
@property (nonatomic,copy)NSString *details;
@property (nonatomic,copy)NSString *dates;
@property (nonatomic,copy)NSString *ID;
@property (nonatomic,copy)NSString *title;

@end
