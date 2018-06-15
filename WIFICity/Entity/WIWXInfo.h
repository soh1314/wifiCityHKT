//
//  WIWXInfo.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/15.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WIModel.h"
//{
//    city = Changsha;
//    country = CN;
//    headimgurl = "http://thirdwx.qlogo.cn/mmopen/vi_32/ZuxTXv40kMeUyO47Qb9yaWd9ubUH78YNuDUXhxXiaVV7HE9doBpnSvaMv7dbIpNibUuG5eic42z8mibAYoia0GoYWdQ/132";
//    language = "zh_CN";
//    nickname = "\U518d\U89c1\U5b59\U609f\U7a7a";
//    openid = o5E0jw0noPVH8yUgX3tPhcbpD2bU;
//    privilege =     (
//    );
//    province = Hunan;
//    sex = 1;
//    unionid = "oYG7Nv4hHifXVXWH3Mpm_5tFyFtI";
//}
@interface WIWXInfo : WIModel

@property (nonatomic,copy)NSString *city;
@property (nonatomic,copy)NSString *country;
@property (nonatomic,copy)NSString *headimgurl;
@property (nonatomic,copy)NSString *language;
@property (nonatomic,copy)NSString *nickname;
@property (nonatomic,copy)NSString *openid;
@property (nonatomic,copy)NSString *province;
@property (nonatomic,assign)BOOL sex;
@property (nonatomic,copy)NSString *unionid;

@end
