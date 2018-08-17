//
//  LoginController.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/13.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "LoginController.h"
#import "IAccountLogin.h"
#import "LoginController2.h"
#import "GCDThrottle.h"
#import "LoginRegex.h"

@interface LoginController ()<UITextFieldDelegate>

@property (nonatomic,strong) WIUser *userInfo;
@property (nonatomic,strong) IAccountLogin *loginer;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initWifiInfo];
     [self setWhiteTrasluntNavBar];
    // Do any additional setup after loading the view from its nib.
}

- (void)initUI {
    self.seperatorLine.backgroundColor = [UIColor whiteColor];
    [self.phoneTtf setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.phoneTtf.tintColor = [UIColor whiteColor];
    self.loginBtn.backgroundColor = [UIColor colorWithHexString:@"#00A1E9"];
    self.loginBtn.titleLabel.textColor = [UIColor colorWithHexString:@"#222222"];
    self.loginBtn.clipsToBounds = YES;
    self.loginBtn.layer.cornerRadius = 22;
    self.otherLoginTextLabel.textColor = [UIColor colorWithHexString:@"#BDBDBD"];
    self.phoneTtf.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneTtf.clearButtonMode = UITextFieldViewModeAlways;
    self.phoneTtf.delegate = self;
    [self.loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [self.wechatLogin addTarget:self action:@selector(wechatLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.qqLoginBtn addTarget:self action:@selector(qqLogin:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)initWifiInfo {
    self.userInfo = [[WIUser alloc]init];
    self.loginer = [[IAccountLogin alloc]init];
    
}

#pragma mark - textfield delegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == self.phoneTtf) {
        if (self.phoneTtf.text.length >= 11) {
            if ([string isEqualToString:@""]) {
                
                return YES;
            }
            else {
                return NO;
            }
        } else {
           
            return YES;
        }
    }
    
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.phoneTtf) {
        if (self.phoneTtf.text.length >= 11) {
            
        } else {

        }
    }
}

- (WIUser *)inputUser {
    WIUser *user =  [WIUser new];
    user.phone = [self.phoneTtf.text copy];
    return user;
}

#pragma mark - btn method

- (void)login:(id)sender {
    if (![LoginRegex checkoutPhoneNum:self.phoneTtf.text]) {
        return;
    }
    __weak typeof(self)welf = self;

    [self.loginer requestVerifyCode:[self inputUser] complete:^(WINetResponse *response) {
        if (response.success) {
            [[AccountManager shared]countDown:nil];
            [self.phoneTtf resignFirstResponder];
            [welf pushToLogin2Controller];
        } else {
            [Dialog simpleToast:response.msg];
        }
    }];

}

- (void)pushToLogin2Controller {
    [GCDThrottle throttle:0.5 block:^{
        WIUser *user = [self inputUser];
        if (user.phone.length >= 11) {
            LoginController2 *controller = [[LoginController2 alloc]init];
            controller.user = user;
            [self.navigationController pushViewController:controller animated:YES];
        }
    }];
}

- (void)wechatLogin:(id)sender {
    [Dialog showWindowToast];
    [self.loginer MOBThirdLogin:WIWXLogin complete:^(WINetResponse *response) {
        [Dialog hideWindowToast];
        if (response && response.success) {
            WIUser *user = [[WIUser alloc]initWithDictionary:response.obj error:nil];
            [[AccountManager shared]saveUserInfo:user];
            [AccountManager shared].user = user;
            [[NSNotificationCenter defaultCenter]postNotificationName:WILoginSuccessNoti object:nil];
            [NavManager dismissLoginController:self];
        } else {
            
        }
    }];
}

- (void)qqLogin:(id)sender {
    [Dialog showWindowToast];
    [self.loginer MOBThirdLogin:WIQQLogin complete:^(WINetResponse *response) {
        [Dialog hideWindowToast];
        if (response && response.success) {
            WIUser *user = [[WIUser alloc]initWithDictionary:response.obj error:nil];
            [[AccountManager shared]saveUserInfo:user];
            [AccountManager shared].user = user;
            [[NSNotificationCenter defaultCenter]postNotificationName:WILoginSuccessNoti object:nil];
            [NavManager dismissLoginController:self];
        } else {
            
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
