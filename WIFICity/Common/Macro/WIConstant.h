//
//  WIConstant.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/12.
//  Copyright © 2018年 HKT. All rights reserved.
//

#ifndef WIConstant_h
#define WIConstant_h

#ifdef __OBJC__

//tabbar
#define tabbar_shouye           @"首页"
#define tabbar_wifi             @"wifi检测"
#define tabbar_square          @"企业广场"
#define tabbar_promoteHelper    @"推广助手"
#define tabbar_userCenter       @"个人中心"

// userdefault
#define FirstEnterAPP @"firstEnterAPP"

#endif

#import "WINotiConst.h"
static NSString *const LoginVerfifyCodeNullError = @"验证码不能为空";
static NSString *const LoginQQUninstallError = @"您未安装QQ，请先安装最新QQ手机版";
static NSString *const LoginWXUninstallError = @"您未安装微信，请先安装微信";
static NSString *const WIFIConnectToastWord = @"wifi已连接";
static NSString *const MobThirdLoginAvartarKey = @"ThridLoginAvatarKey";

static NSString *const WIPanoramaUrl = @"https://720yun.com/t/946jezwnuv5?scene_id=17042939&from=groupmessage";

typedef NS_ENUM(NSInteger,WINetStatus) {
    WINetWifi = 0,
    WINet4G = 1,
    WINetFail = 2
};
static NSString *const LASTHKTWIFIMACKEY = @"LastHKTWifiMacKey";
static NSString *const LASTHKTWIFIORGIDKEY = @"LastHKTWifiOrgIdKey";
static NSString *const HOMEAPSERVICEKEY = @"HomeAPServiceKey";
static NSString *const HKTWIFIARRAYKEY = @"HKTWifiArrayKey";
static NSString *const OHERWIFIARRAYKEY = @"OtherWifiArrayKey";
static NSString *const HKTWIFIMACPREFIX = @"dc:37";


#endif /* WIConstant_h */
