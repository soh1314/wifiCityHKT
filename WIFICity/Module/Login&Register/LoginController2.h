//
//  LoginController2.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/13.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "BaseViewController.h"
#import "WIUser.h"

@interface LoginController2 : BaseViewController

@property (nonatomic,strong)WIUser *user;
@property (weak, nonatomic) IBOutlet UIButton *verifyBtn;
@property (weak, nonatomic) IBOutlet UIView *verifyCodeTtf;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UILabel *verifycodeNotiLabel;
- (IBAction)login:(id)sender;
- (IBAction)requestVerfiyCode:(id)sender;
- (IBAction)back:(id)sender;

@end
