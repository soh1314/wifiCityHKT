//
//  WIUser.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/12.
//  Copyright © 2018年 HKT. All rights reserved.
//


#import "WIModel.h"
//createBy = "<null>";
//createDate = 1533880095000;
//createName = "<null>";
//id = ff80818165123a130165139cdf120267;
//integral = "<null>";
//integralCount = "<null>";
//isManage = "<null>";
//memberLevel = "<null>";
//nickname = "\U518d\U89c1\U5b59\U609f\U7a7a";
//openid = o5E0jw0noPVH8yUgX3tPhcbpD2bU;
//phone = 15874278508;
//qqIcon = "http://qzapp.qlogo.cn/qzapp/1106178641/C52CC8822256DC2503492E9888FDF814/100";
//qqOpenid = C52CC8822256DC2503492E9888FDF814;
//type = wx;
//updateBy = "<null>";
//updateDate = "<null>";
//updateName = "<null>";
//verifyCode = 3515;
//wxIcon = "http://thirdwx.qlogo.cn/mmopen/vi_32/ZuxTXv40kMeUyO47Qb9yaWd9ubUH78YNuDUXhxXiaVV7HE9doBpnSvaMv7dbIpNibUuG5eic42z8mibAYoia0GoYWdQ/132";
//wxOpenid = o5E0jw0noPVH8yUgX3tPhcbpD2bU;
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
@property (nonatomic,copy)NSString *avartar;
@property (nonatomic,copy)NSString *memberLevel;
@property (nonatomic,copy)NSDictionary *wxinfo;
@property (nonatomic,copy)NSDictionary *qqinfo;
@property (nonatomic,copy)NSString *wxName;
@property (nonatomic,copy)NSString *qqName;
@property (nonatomic,copy)NSString *untieType;

@end
