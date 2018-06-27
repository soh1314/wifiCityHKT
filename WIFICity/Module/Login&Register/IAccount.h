//
//  IAccount.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/13.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WIUser.h"

typedef void(^IAccountCompleteBlock)(WINetResponse *response);

@protocol IAccount <NSObject>

- (void)registerUser:(WIUser *)user complete:(IAccountCompleteBlock)complete;

- (void)loginUser:(WIUser *)user complete:(IAccountCompleteBlock)complete;

- (void)requestVerifyCode:(WIUser *)user complete:(IAccountCompleteBlock)complete;

- (void)requestBindPhoneVerifyCode:(WIUser *)user complete:(IAccountCompleteBlock)complete;

- (void)bindPhone:(WIUser *)user complete:(IAccountCompleteBlock)complete;

@end
