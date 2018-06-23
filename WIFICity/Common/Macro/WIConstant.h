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
#define tabbar_movie             @"电影"
#define tabbar_square          @"企业广场"
#define tabbar_promoteHelper    @"推广助手"
#define tabbar_userCenter       @"个人中心"

// userdefault
#define FirstEnterAPP @"firstEnterAPP"

#endif

#import "WINotiConst.h"
static NSString *const LoginVerfifyCodeNullError = @"验证码不能为空";

static NSString *const WIFIConnectToastWord = @"wifi已连接";

typedef NS_ENUM(NSInteger,WINetStatus) {
    WINetWifi = 0,
    WINet4G = 1,
    WINetFail = 2
};

#endif /* WIConstant_h */
