//
//  SDKConfig.m
//  SDKPacket
//
//  Created by 刘仰清 on 2017/8/30.
//  Copyright © 2017年 HearMe. All rights reserved.
//

#import "SDKConfig.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

#pragma GCC diagnostic ignored "-Wdeprecated-declarations"

@interface SDKConfig ()

@end

@implementation SDKConfig

+ (instancetype)shared {
    static SDKConfig *sdkCofig = nil;
    static dispatch_once_t once_tokn;
    dispatch_once(&once_tokn, ^{
        sdkCofig = [[self alloc]init];
    });
    return sdkCofig;
}

+(void)configMobShare {
    NSArray *platforms = @[@(SSDKPlatformTypeWechat),@(SSDKPlatformTypeQQ)];
    [ShareSDK registerActivePlatforms:platforms
                             onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             default:
                 break;
         }
     }
                      onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:WXAPPID
                                       appSecret:WXSECRET];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:QQAPPID
                                      appKey:QQAPPKEY
                                    authType:SSDKAuthTypeBoth];
                 break;

             default:
                 break;
         }
     }];
}

+ (void)cancleThirdLoginAuthorize {
    [ShareSDK cancelAuthorize:SSDKPlatformTypeQQ];
    [ShareSDK cancelAuthorize:SSDKPlatformTypeWechat];
}

+ (void)cancleQQLoginAuthorize  {
    [ShareSDK cancelAuthorize:SSDKPlatformTypeQQ];
}

+ (void)cancleWXLoginAuthorize  {
    [ShareSDK cancelAuthorize:SSDKPlatformTypeWechat];
    
}


@end
