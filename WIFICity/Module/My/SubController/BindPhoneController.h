//
//  BindPhoneController.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/8/10.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "BaseViewController.h"

@interface BindPhoneController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *phoneTtf;
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTtf;
@property (weak, nonatomic) IBOutlet UIButton *verifyBtn;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property (nonatomic,assign) BOOL bindNewPhone;

- (IBAction)requestVerifyCode:(id)sender;
- (IBAction)bindBtn:(id)sender;


@end
