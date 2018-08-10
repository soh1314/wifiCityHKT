//
//  BindAccountController.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/8/10.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "BaseViewController.h"

@interface BindAccountController : BaseViewController
@property (weak, nonatomic) IBOutlet UISwitch *bindWxSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *bindQQSwitch;
@property (weak, nonatomic) IBOutlet UILabel *qqLabel;
@property (weak, nonatomic) IBOutlet UILabel *wxLabel;

@end
