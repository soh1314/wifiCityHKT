//
//  LoginController.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/13.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *phoneTtf;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *wechatLogin;
@property (weak, nonatomic) IBOutlet UILabel *otherLoginTextLabel;
@property (weak, nonatomic) IBOutlet UIView *seperatorLine;
@property (weak, nonatomic) IBOutlet UIButton *qqLoginBtn;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@end
