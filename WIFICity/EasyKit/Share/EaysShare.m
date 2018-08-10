//
//  EaysShare.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/4.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "EaysShare.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

static NSString *const ShareAPPText = @"极速免费wifi上网！";
static NSString *const ShareAPPUrl = @"https://itunes.apple.com/cn/app/%E5%9F%8E%E5%B8%82%E6%97%A0%E7%BA%BF/id1298467690?mt=8";
static NSString *const ShareAPPTitle = @"长沙地区公益性免费WiFi上网工具，安全可靠，公安认证";
static NSString *const ShareAPPImage = @"MobShrare";

@implementation EaysShare

+ (void)shareApp {
    NSArray* imageArray = @[[UIImage imageNamed:ShareAPPImage]];

    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:ShareAPPText
                                     images:imageArray
                                        url:[NSURL URLWithString:ShareAPPUrl]
                                      title:ShareAPPTitle
                                       type:SSDKContentTypeAuto];
    [shareParams SSDKSetupWeChatParamsByText:ShareAPPText   title:ShareAPPTitle
                                         url:[ShareAPPUrl copy]
                                  thumbImage:nil
                                       image:imageArray[0]
                                musicFileURL:nil
                                     extInfo:nil
                                    fileData:nil
                                emoticonData:nil
                                        type:SSDKContentTypeAuto  forPlatformSubType:SSDKPlatformSubTypeWechatSession];
    [ShareSDK share:SSDKPlatformSubTypeWechatSession parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        
    }];
     
}

@end

