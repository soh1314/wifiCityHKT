//
//  IAccountLogin.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/13.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IAccount.h"

typedef NS_ENUM(NSInteger,WILoginType) {
    WIQQLogin = 0,
    WIWXLogin = 1,
    WINormalLogin
};

@interface IAccountLogin : NSObject <IAccount>

- (void)loginUser:(WIUser *)user complete:(IAccountCompleteBlock)complete;

- (void)registerUser:(WIUser *)user complete:(IAccountCompleteBlock)complete;

- (void)requestVerifyCode:(WIUser *)user complete:(IAccountCompleteBlock)complete;

- (void)wechatLogin:(WIUser *)user complete:(IAccountCompleteBlock)complete;

- (void)MOBThirdLogin:(WILoginType)loginType complete:(IAccountCompleteBlock)complete;

- (void)requestBindPhoneVerifyCode:(WIUser *)user complete:(IAccountCompleteBlock)complete;

- (void)bindPhone:(WIUser *)user complete:(IAccountCompleteBlock)complete;

@end
