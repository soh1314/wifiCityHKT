//
//  IAccountLogin.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/13.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "IAccountLogin.h"
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>

#define APPLoginAPI @"/ws/user/verifyLogin.do"
#define RegisterVerifyCodeAPI @"/ws/user/verifyPhone.do"
#define ThirdLoginAPI @"/ws/user/thirdLogin.do"

@implementation IAccountLogin

- (void)loginUser:(WIUser *)user complete:(IAccountCompleteBlock)complete {
    
}

- (void)registerUser:(WIUser *)user complete:(IAccountCompleteBlock)complete {
    NSDictionary *para = @{@"phone":[user.phone copy],@"verifyCode":[user.verifyCode copy]};
    [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, APPLoginAPI) params:para successBlock:^(NSDictionary *returnData) {
        WIUser *user = [[WIUser alloc]initWithDictionary:returnData[@"obj"] error:nil];
        NSLog(@"注册用户: %@",user);
        WINetResponse *respone = [[WINetResponse alloc]initWithDictionary:returnData error:nil];
        complete([respone copy]);
    } failureBlock:^(NSError *error) {
        
    } showHUD:NO];
}

- (void)wechatLogin:(WIUser *)user complete:(IAccountCompleteBlock)complete {
    
}

- (void)requestVerifyCode:(WIUser *)user complete:(IAccountCompleteBlock)complete {
    NSDictionary *para = @{@"phone":[user.phone copy]};
    [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, RegisterVerifyCodeAPI) params:para successBlock:^(NSDictionary *returnData) {
        WINetResponse *respone = [[WINetResponse alloc]initWithDictionary:returnData error:nil];
        complete([respone copy]);
    } failureBlock:^(NSError *error) {
        kHudNetError;
    } showHUD:NO];
}

- (void)MOBThirdLogin:(WILoginType)loginType {
    SSDKPlatformType platformType = 0;
    if (loginType == WIQQLogin) {
         platformType = SSDKPlatformTypeQQ;
    }
    if (loginType == WIWXLogin) {
        platformType = SSDKPlatformTypeWechat;
    }
    [SSEThirdPartyLoginHelper loginByPlatform:platformType
                                   onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
                                       
                                       //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
                                       //在此示例中没有跟用户系统关联，则使用一个社交用户对应一个系统用户的方式。将社交用户的uid作为关联ID传入associateHandler。
                                       associateHandler (user.uid, user, user);
                                       NSLog(@"dd%@",user.rawData);
                                       NSLog(@"dd%@",user.credential);
                                       
                                   }
                                onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
                                    
                                    if (state == SSDKResponseStateSuccess)
                                    {
                                        
                                    }
                                    
                                }];
}

- (WIUser *)associateThirdUser:(SSDKUser *)sdkUser {
    WIUser *user = [WIUser new];
    return user;
}

- (void)WIThirdLogin:(WIUser *)user complete:(IAccountCompleteBlock)complete {

    NSDictionary *para = @{@"type":user.loginType,@"openid":@"",@"nickname":@""};
    [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, ThirdLoginAPI) params:para successBlock:^(NSDictionary *returnData) {
        WINetResponse *respone = [[WINetResponse alloc]initWithDictionary:returnData error:nil];
        complete([respone copy]);
    } failureBlock:^(NSError *error) {
        kHudNetError;
    } showHUD:NO];
}

@end
