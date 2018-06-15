//
//  SDKConfig.h
//  SDKPacket
//
//  Created by 刘仰清 on 2017/8/30.
//  Copyright © 2017年 HearMe. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "ThirdSDK.h"

@interface SDKConfig : NSObject

@property (nonatomic,assign)BOOL enterApp;

+ (instancetype)shared;
+(void)configMobShare;
+ (void)cancleThirdLoginAuthorize;

@end
