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
    if ([AccountManager shared].user.wxOpenid) {
        self.wxLabel.text = [NSString stringWithFormat:@"微信号 (%@)",[AccountManager shared].user.nickname];
        self.bindWxSwitch.on = YES;
    } else {
       self.bindWxSwitch.on = NO;
    }
    
    if ( [AccountManager shared].user.qqOpenid ) {
        self.qqLabel.text = [NSString stringWithFormat:@"QQ号 (%@)",[AccountManager shared].user.nickname];
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
                [[AccountManager shared]saveUserInfo:user];
                [AccountManager shared].user = user;
                [Dialog toastCenter:@"绑定成功"];
                self.bindQQSwitch.on = YES;
                self.qqLabel.text = [NSString stringWithFormat:@"QQ号 (%@)",[AccountManager shared].user.nickname];
            } else {
                [Dialog toastCenter:@"绑定失败"];
                self.bindQQSwitch.on = NO;
            }
        }];

    } else {
//        self.bindQQSwitch.on = YES;
        [SDKConfig cancleQQLoginAuthorize];
        [AccountManager shared].user.qqOpenid = nil;
        self.qqLabel.text = @"QQ号";
//        [Dialog toastCenter:@"暂时不支持解绑"];
        
    }

}

- (void)switchWXbind:(id)sender {
    if (self.bindWxSwitch.isOn) {
        WIUser *user = [WIUser new];
        user.type = @"wx";
        [self.dispatch WIThirdBind:user complete:^(WINetResponse *response) {
            if (response && response.success) {
                WIUser *user = [[WIUser alloc]initWithDictionary:response.obj error:nil];
                [[AccountManager shared]saveUserInfo:user];
                [AccountManager shared].user = user;
                self.bindWxSwitch.on = YES;
                self.wxLabel.text = [NSString stringWithFormat:@"微信号 (%@)",[AccountManager shared].user.nickname];
                [Dialog toastCenter:@"绑定成功"];
            } else {
                [Dialog toastCenter:@"绑定失败"];
            }
        }];
    } else {
//        self.bindWxSwitch.on = YES;
        [SDKConfig cancleWXLoginAuthorize];
        [AccountManager shared].user.wxOpenid = nil;
        self.wxLabel.text = @"微信号";
//        [Dialog toastCenter:@"暂时不支持解绑"];
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
