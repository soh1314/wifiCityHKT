 //
//  BindPhoneView.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/26.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BindPhoneInputPwdView.h"
#import "BindPhoneInputPhoneView.h"
#import "BindPhoneModel.h"
#import "IAccountLogin.h"
typedef void(^CloseActionBlock)(void);

@interface BindPhoneView : UIView

@property (nonatomic,strong)BindPhoneInputPwdView *inputPwdView;
@property (nonatomic,strong)BindPhoneInputPhoneView *inputPhoneView;
@property (nonatomic,strong)BindPhoneModel *bindPhoneModel;
@property (nonatomic,copy)CloseActionBlock closeBlock;
@property (nonatomic,strong)IAccountLogin *accountLogin;

@end
