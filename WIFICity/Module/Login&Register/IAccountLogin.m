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
#define APPLoginAPI @"/v1/login.do"
#define RegisterVerifyCodeAPI @"/v1/captcha.do"
#define ThirdLoginAPI @"/ws/user/login.do"
#define ThirdBindAPI @"/ws/user/bingUser.do"
#define ThirdUnBindAPI @"/ws/user/untieUser.do"


@implementation IAccountLogin

- (void)loginUser:(WIUser *)user complete:(IAccountCompleteBlock)complete {
    
}

- (void)registerUser:(WIUser *)user complete:(IAccountCompleteBlock)complete {
    if (!user.verifyCode || [user.verifyCode isEqualToString:@""]) {
        [Dialog simpleToast:LoginVerfifyCodeNullError];
        return;
    }
    NSDictionary *para = @{@"account":[user.phone copy],@"captcha":[user.verifyCode copy],@"type":@"1"};
    [MHNetworkManager postReqeustWithURL:kAppUrl(kUrlHost, APPLoginAPI) params:para successBlock:^(NSDictionary *returnData) {
        WIUser *user = [[WIUser alloc]initWithDictionary:returnData[@"obj"] error:nil];
        NSLog(@"注册用户: %@",user);
        NSLog(@"手机账号登录%@",returnData);
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
    NSDictionary *para = @{@"phoneNumber":[user.phone copy]};
    [Dialog showWindowToast];
    [MHNetworkManager postReqeustWithURL:kAppUrl(kUrlHost, RegisterVerifyCodeAPI) params:para successBlock:^(NSDictionary *returnData) {
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
                 newUser.loginType = 3;
             } else {
                 newUser.loginType = 2;
             }
             [self WIThirdLogin:newUser complete:^(WINetResponse *response) {
                 complete(response);
             }];
         } else if (state == SSDKResponseStateCancel) {
             complete(nil);
             [Dialog simpleToast:@"取消第三方调用"];
         } else
         {
             complete(nil);
             if (![QQApiInterface isQQInstalled] && loginType == WIQQLogin) {
                 [Dialog simpleToast:LoginQQUninstallError];
             }
             if (![WXApi isWXAppInstalled] && loginType == WIWXLogin) {
                 [Dialog simpleToast:LoginWXUninstallError];
             }
             kHudNetError;
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

- (void)WIThirdUnBind:(WIUser *)user complete:(IAccountCompleteBlock)complete {
    NSDictionary *par = @{@"id":user.userId,@"untieType":user.untieType};
    [MHNetworkManager postReqeustWithURL:kAppUrl(kUrlHost, ThirdUnBindAPI) params:par successBlock:^(NSDictionary *returnData) {
        WINetResponse *response = [[WINetResponse alloc]initWithDictionary:returnData error:nil];
        complete(response);
    } failureBlock:^(NSError *error) {
        kHudNetError;
    } showHUD:NO];
}

- (void)WIThirdBind:(WIUser *)user complete:(IAccountCompleteBlock)complete {
    SSDKPlatformType platformType = 0;
    if (user.type == 3) {
        platformType = SSDKPlatformTypeQQ;
    }
    if (user.type == 2) {
        platformType = SSDKPlatformTypeWechat;
    }
    [ShareSDK getUserInfo:platformType
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             WIUser *newUser = [self associateThirdUser:user];
             [EasyCacheHelper saveResponseCache:user.icon forKey:MobThirdLoginAvartarKey];
             NSString *openid = nil;
             if (platformType == SSDKPlatformTypeWechat) {
                 openid = newUser.wxOpenid;
                 newUser.loginType = 2;
             } else {
                 openid = newUser.qqOpenid;
                  newUser.loginType = 3;
             }
//             NSDictionary *para = @{@"bingType":newUser.loginType,@"openid":openid,@"nickname":newUser.nickname,@"icon":[newUser.avartar copy],@"id":[AccountManager shared].user.userId};
//             [MHNetworkManager postReqeustWithURL:kAppUrl(kUrlHost, ThirdBindAPI) params:para successBlock:^(NSDictionary *returnData) {
//                 WINetResponse *respone = [[WINetResponse alloc]initWithDictionary:returnData error:nil];
//                 complete([respone copy]);
//             } failureBlock:^(NSError *error) {
//                 kHudNetError;
//             } showHUD:NO];
             
         } else if (state == SSDKResponseStateCancel) {
             complete(nil);
             [Dialog simpleToast:@"取消第三方绑定"];
         } else
         {
             complete(nil);
             if (![QQApiInterface isQQInstalled] &&  platformType == SSDKPlatformTypeQQ) {
                 [Dialog simpleToast:LoginQQUninstallError];
                 return ;
             }
             if (![WXApi isWXAppInstalled] && platformType == SSDKPlatformTypeWechat) {
                 [Dialog simpleToast:LoginWXUninstallError];
                 return ;
             }
             kHudNetError;
         }
         
     }];

}

- (void)WIThirdLogin:(WIUser *)user complete:(IAccountCompleteBlock)complete {
    NSString *openid = nil;
    if (user.loginType == 2) {
        openid = user.wxOpenid;
    } else {
        openid = user.qqOpenid;
    }
//    NSDictionary *para = @{@"loginType":user.loginType,@"openid":openid,@"nickname":user.nickname,@"icon":[user.avartar copy]};
//    [MHNetworkManager postReqeustWithURL:kAppUrl(kUrlHost, ThirdLoginAPI) params:para successBlock:^(NSDictionary *returnData) {
//        WINetResponse *respone = [[WINetResponse alloc]initWithDictionary:returnData error:nil];
//        NSLog(@"第三方登录%@",respone.obj);
//        complete([respone copy]);
//    } failureBlock:^(NSError *error) {
//        kHudNetError;
//    } showHUD:NO];
}

- (void)requestBindPhoneVerifyCode:(WIUser *)user complete:(IAccountCompleteBlock)complete {
    NSDictionary *para = @{@"phone":user.phone};
    [MHNetworkManager postReqeustWithURL:kAppUrl(kUrlHost, BindUserVerifyCodeAPI) params:para successBlock:^(NSDictionary *returnData) {
        WINetResponse *response = [WINetResponse new];
        if (returnData && [returnData objectForKey:@"obj"]) {
            NSInteger code = [[returnData objectForKey:@"obj"]integerValue];
            [AccountManager shared].bindCode = [NSString stringWithFormat:@"%ld",code];
            response.success = YES;
            response.intObj = code;
            complete(response);
        } else {
            response.success = NO;
            [Dialog simpleToast:[returnData objectForKey:@"msg"]];
        }
        
    } failureBlock:^(NSError *error) {
        [MBProgressHUD hideHUDForView:KWINDOW animated:YES];
        kHudNetError;
    } showHUD:NO];
}

- (void)bindPhone:(WIUser *)user complete:(IAccountCompleteBlock)complete {
    NSDictionary *para = @{@"phone":user.phone,@"verifyCode":user.verifyCode,@"bingType":@"sj",@"id":[AccountManager shared].user.userId};
    [MHNetworkManager postReqeustWithURL:kAppUrl(kUrlHost, BindUserAPI) params:para successBlock:^(NSDictionary *returnData) {
        WINetResponse *respone = [[WINetResponse alloc]initWithDictionary:returnData error:nil];
        complete([respone copy]);
    } failureBlock:^(NSError *error) {
        kHudNetError;
    } showHUD:NO];
}

@end
