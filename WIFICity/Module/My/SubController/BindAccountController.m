//
//  BindAccountController.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/8/10.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "BindAccountController.h"
#import "IAccountLogin.h"
#import "SDKConfig.h"
@interface BindAccountController ()

@property (nonatomic,strong)IAccountLogin *dispatch;
@end

@implementation BindAccountController

- (id)init {
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定账号";
    self.dispatch = [IAccountLogin new];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
    [self.bindWxSwitch addTarget:self action:@selector(switchWXbind:) forControlEvents:UIControlEventTouchUpInside];
     [self.bindQQSwitch addTarget:self action:@selector(switchQQbind:) forControlEvents:UIControlEventTouchUpInside];
    [self setBlackNavBar];
    if ([AccountManager shared].user.wxName && ![[AccountManager shared].user.wxName isEqualToString:@""]) {
        self.wxLabel.text = [NSString stringWithFormat:@"微信号 (%@)",[AccountManager shared].user.wxName];
        self.bindWxSwitch.on = YES;
    } else {
       self.bindWxSwitch.on = NO;
    }
    
    if ( [AccountManager shared].user.qqName && ![[AccountManager shared].user.qqName isEqualToString:@""]) {
        self.qqLabel.text = [NSString stringWithFormat:@"QQ号 (%@)",[AccountManager shared].user.qqName];
        self.bindQQSwitch.on = YES;
    } else {
        self.bindQQSwitch.on = NO;
    }
    
}

- (void)switchQQbind:(id)sender {
    if (self.bindQQSwitch.isOn) {
        WIUser *user = [WIUser new];
        user.type = @"qq";
        [self.dispatch WIThirdBind:user complete:^(WINetResponse *response) {
            if (response && response.success) {
                WIUser *user = [[WIUser alloc]initWithDictionary:response.obj error:nil];
                NSString *loginType = [[AccountManager shared].user.type copy];
                user.type = [loginType copy];
                [[AccountManager shared]saveUserInfo:user];
                [AccountManager shared].user = user;
                [Dialog toastCenter:@"绑定成功"];
                self.qqLabel.text = [NSString stringWithFormat:@"QQ号 (%@)",[AccountManager shared].user.qqName];
            } else {
                [Dialog toastCenter:@"绑定失败"];
                self.bindQQSwitch.on = NO;
            }
        }];

    } else {

        WIUser *user = [WIUser new];
        user.userId = [[AccountManager shared].user.userId copy];
        user.untieType = @"qq";
        [self.dispatch WIThirdUnBind:user complete:^(WINetResponse *response) {
            if (response && response.success) {
                [SDKConfig cancleQQLoginAuthorize];
                WIUser *user = [[WIUser alloc]initWithDictionary:response.obj error:nil];
                NSString *loginType = [[AccountManager shared].user.type copy];
                user.type = [loginType copy];
                [[AccountManager shared]saveUserInfo:user];
                [AccountManager shared].user = user;
                self.qqLabel.text = @"QQ号";
                [Dialog toastCenter:@"解绑成功"];
                
            } else {
                [Dialog toastCenter:@"解绑失败"];
                self.bindQQSwitch.on = YES;
            }
        }];
        
    }

}

- (void)switchWXbind:(id)sender {
    if (self.bindWxSwitch.isOn) {
        WIUser *user = [WIUser new];
        user.type = @"wx";
        [self.dispatch WIThirdBind:user complete:^(WINetResponse *response) {
            if (response && response.success) {
                WIUser *user = [[WIUser alloc]initWithDictionary:response.obj error:nil];
                NSString *loginType = [[AccountManager shared].user.type copy];
                user.type = [loginType copy];
                [[AccountManager shared]saveUserInfo:user];
                [AccountManager shared].user = user;
                self.wxLabel.text = [NSString stringWithFormat:@"微信号 (%@)",[AccountManager shared].user.wxName];
                [Dialog toastCenter:@"绑定成功"];
            } else {
                [Dialog toastCenter:@"绑定失败"];
                self.bindWxSwitch.on = NO;
            }
        }];
    } else {
        WIUser *user = [WIUser new];
        user.userId = [[AccountManager shared].user.userId copy];
        user.untieType = @"wx";
        [self.dispatch WIThirdUnBind:user complete:^(WINetResponse *response) {
            if (response && response.success) {
                [SDKConfig cancleWXLoginAuthorize];
                WIUser *user = [[WIUser alloc]initWithDictionary:response.obj error:nil];
                NSString *loginType = [[AccountManager shared].user.type copy];
                user.type = [loginType copy];
                [[AccountManager shared]saveUserInfo:user];
                [AccountManager shared].user = user;
                self.wxLabel.text = @"微信号";
                [Dialog toastCenter:@"解绑成功"];

            } else {
                [Dialog toastCenter:@"解绑失败"];
                self.bindWxSwitch.on = YES;
            }
        }];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
