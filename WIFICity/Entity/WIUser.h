//
//  WIUser.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/12.
//  Copyright © 2018年 HKT. All rights reserved.
//


#import "WIModel.h"

@interface WIUser : WIModel

@property (nonatomic,copy)NSString *userId;
@property (nonatomic,copy)NSString *nickname;
@property (nonatomic,copy)NSString *createName;
@property (nonatomic,copy)NSString *createBy;
@property (nonatomic,copy)NSString *createDate;
@property (nonatomic,copy)NSString *updateName;
@property (nonatomic,copy)NSString *updateBy;
@property (nonatomic,copy)NSString *updateDate;
@property (nonatomic,copy)NSString *verifyCode;
@property (nonatomic,copy)NSString *openid;
@property (nonatomic,copy)NSString *qqOpenid;
@property (nonatomic,copy)NSString *wxOpenid;
@property (nonatomic,copy)NSString *phone;
@property (nonatomic,copy)NSString *veriycode;
@property (nonatomic,copy)NSString *type;
@property (nonatomic,assign)int loginState;
@property (nonatomic,copy)NSString *loginType; // 0 wx 1 qq 2 其他

@end
