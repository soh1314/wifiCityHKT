//
//  BindPhoneModel.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/26.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WIModel.h"

@interface BindPhoneModel : WIModel

@property (nonatomic,copy)NSString *phone;
@property (nonatomic,copy)NSString *verifyCode;
@property (nonatomic,copy)NSString *countDown;
@property (nonatomic,assign)BOOL checkProtocol;
@property (nonatomic,assign)BOOL close;
@property (nonatomic,assign)BOOL next;
@property (nonatomic,assign)NSInteger countdownTime;

@end
