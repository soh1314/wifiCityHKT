//
//  AccountManager.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/12.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WIUser.h"

typedef NS_ENUM(NSUInteger, APPLoginState){
    APPHaveLoginState = 0,
    APPLogoutState = 1
};


@interface AccountManager : NSObject

+ (instancetype)shared;

@property (nonatomic,strong)WIUser *user;

@property (nonatomic,assign)BOOL reverifyEnabled;

@property (nonatomic,assign)NSInteger verifyCodeSecond;

@property (nonatomic,assign)BOOL closeCountDown;

+ (WIUser *)currentUser;

+ (APPLoginState)loginState;

+ (void)logout;

- (void)handleWhenAppStart;

- (void)loadUserAccount;

- (void)refreshUserInfo;

- (void)saveUserInfo:(WIUser *)user;

- (void)countDown:(void(^)(NSInteger timeout))block;

@end
