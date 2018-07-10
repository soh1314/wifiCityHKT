//
//  IAccountLogin.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/13.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "IAccountLogin.h"
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WXApi.h"
#import "EasyCacheHelper.h"
#define APPLoginAPI @"/ws/user/verifyLogin.do"
#define RegisterVerifyCodeAPI @"/ws/user/verifyPhone.do"
#define ThirdLoginAPI @"/ws/user/thirdLogin.do"



@implementation IAccountLogin

- (void)loginUser:(WIUser *)user complete:(IAccountCompleteBlock)complete {
    
}

- (void)registerUser:(WIUser *)user complete:(IAccountCompleteBlock)complete {
    if (!user.verifyCode || [user.verifyCode isEqualToString:@""]) {
        [Dialog simpleToast:LoginVerfifyCodeNullError];
        return;
    }
    NSDictionary *para = @{@"phone":[user.phone copy],@"verifyCode":[user.verifyCode copy]};
    [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, APPLoginAPI) params:para successBlock:^(NSDictionary *returnData) {
        WIUser *user = [[WIUser alloc]initWithDictionary:returnData[@"obj"] error:nil];
        NSLog(@"注册用户: %@",user);
        NSLog(@"登录%@",returnData);
        WINetResponse *respone = [[WINetResponse alloc]initWithDictionary:returnData error:nil];
        [NetErrorHandle handleResponse:respone];
        complete([respone copy]);
    } failureBlock:^(NSError *error) {
        kHudNetError;
    } showHUD:NO];
}

- (void)wechatLogin:(WIUser *)user complete:(IAccountCompleteBlock)complete {
    
}

- (void)requestVerifyCode:(WIUser *)user complete:(IAccountCompleteBlock)complete {
    NSDictionary *para = @{@"phone":[user.phone copy]};
    [Dialog showWindowToast];
    [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, RegisterVerifyCodeAPI) params:para successBlock:^(NSDictionary *returnData) {
        [Dialog hideWindowToast];
        WINetResponse *respone = [[WINetResponse alloc]initWithDictionary:returnData error:nil];
        complete([respone copy]);
    } failureBlock:^(NSError *error) {
        [Dialog hideWindowToast];
        kHudNetError;
    } showHUD:NO];
}

- (void)MOBThirdLogin:(WILoginType)loginType complete:(IAccountCompleteBlock)complete{
    SSDKPlatformType platformType = 0;
    if (loginType == WIQQLogin) {
         platformType = SSDKPlatformTypeQQ;
    }
    if (loginType == WIWXLogin) {
        platformType = SSDKPlatformTypeWechat;
    }
    [ShareSDK getUserInfo:platformType
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             WIUser *newUser = [self associateThirdUser:user];
             [EasyCacheHelper saveResponseCache:user.icon forKey:MobThirdLoginAvartarKey];
             if (loginType == WIQQLogin) {
                 newUser.loginType = @"qq";
             } else {
                 newUser.loginType = @"wx";
             }
             [self WIThirdLogin:newUser complete:^(WINetResponse *response) {
                 complete(response);
             }];
         } else if (state == SSDKResponseStateCancel) {
             complete(nil);
             [Dialog simpleToast:@"取消第三方登录"];
         } else
         {
             complete(nil);
             if (![QQApiInterface isQQInstalled] && loginType == WIQQLogin) {
                 [Dialog simpleToast:LoginQQUninstallError];
             }
             if (![WXApi isWXAppInstalled] && loginType == WIWXLogin) {
                 [Dialog simpleToast:LoginWXUninstallError];
             }
             NSLog(@"%@",error);
         }
         
     }];
    
}

- (WIUser *)associateThirdUser:(SSDKUser *)sdkUser {
    WIUser *user = [WIUser new];
    user.nickname = sdkUser.nickname;
    user.wxOpenid = [sdkUser.uid copy];
    user.qqOpenid = [sdkUser.uid copy];
    user.avartar = [sdkUser.icon copy];
    return user;
}

- (void)WIThirdLogin:(WIUser *)user complete:(IAccountCompleteBlock)complete {
    NSString *openid = nil;
    if ([user.loginType isEqualToString:@"wx"]) {
        openid = user.wxOpenid;
    } else {
        openid = user.qqOpenid;
    }
    NSDictionary *para = @{@"type":user.loginType,@"openid":openid,@"nickname":user.nickname};
    [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, ThirdLoginAPI) params:para successBlock:^(NSDictionary *returnData) {
        WINetResponse *respone = [[WINetResponse alloc]initWithDictionary:returnData error:nil];
        complete([respone copy]);
    } failureBlock:^(NSError *error) {
        kHudNetError;
    } showHUD:NO];
}

- (void)requestBindPhoneVerifyCode:(WIUser *)user complete:(IAccountCompleteBlock)complete {
    NSDictionary *para = @{@"phone":user.phone};
    [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, BindUserVerifyCodeAPI) params:para successBlock:^(NSDictionary *returnData) {
        WINetResponse *response = [WINetResponse new];
        if (returnData && [returnData objectForKey:@"obj"]) {
            NSInteger code = [[returnData objectForKey:@"obj"]integerValue];
            [AccountManager shared].bindCode = [NSString stringWithFormat:@"%ld",code];
            response.success = YES;
            complete(response);
        } else {
            response.success = NO;
            [Dialog simpleToast:[returnData objectForKey:@"msg"]];
        }
        
    } failureBlock:^(NSError *error) {
        kHudNetError;
    } showHUD:NO];
}

- (void)bindPhone:(WIUser *)user complete:(IAccountCompleteBlock)complete {
    NSDictionary *para = @{@"phone":user.phone,@"verifyCode":user.verifyCode,@"bingType":@"sj",@"id":[AccountManager shared].user.userId};
    [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, BindUserAPI) params:para successBlock:^(NSDictionary *returnData) {
        WINetResponse *respone = [[WINetResponse alloc]initWithDictionary:returnData error:nil];
        complete([respone copy]);
    } failureBlock:^(NSError *error) {
        kHudNetError;
    } showHUD:NO];
}

@end
