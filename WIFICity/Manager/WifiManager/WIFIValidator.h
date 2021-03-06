//
//  WIFIValidator.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/25.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WifiUtil.h"
#import "WIFIValidateInfo.h"

typedef NS_ENUM(NSInteger,WIFIValidateStatus){
    WIFIValidateFail = 0,
    WIFIValidateSuccess,
    WIFIValidateProcess
    
};

@interface WIFIValidator : NSObject

+ (instancetype)shared;

@property (nonatomic,copy,readonly)NSString *lastHktWifiMac;
@property (nonatomic,assign)WIFIValidateStatus validateStatus;
@property (nonatomic,assign)BOOL reconnect;
@property (nonatomic,assign)BOOL sendValidateNoti;
@property (nonatomic,assign)BOOL resetExpireTime;

- (BOOL)needValidator:(WIFIValidateInfo *)info;
- (void)validator;



- (void)validatorWhenAppTerminate;
- (void)backGroundValidator;

@end
