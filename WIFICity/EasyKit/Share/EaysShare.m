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

static NSString *const ShareAPPText = @"一键获取你所想要的免费WIFI";
static NSString *const ShareAPPUrl = @"http://www.hktchn.com";
static NSString *const ShareAPPTitle = @"华宽通免费WifiAPP";
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
