//
//  LoginController2.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/13.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "LoginController2.h"
#import "TPPasswordTextView.h"
#import "WIPasswordView.h"
#import "IAccountLogin.h"

static NSString *const LoginVerifySendSuccess = @"验证码发送成功";
static NSString *const LoginVerifySendFail = @"验证码发送失败";

@interface LoginController2 ()

@property (nonatomic,strong)WIPasswordView *pwdView;
@property (nonatomic,strong)IAccountLogin *loginer;
@property (nonatomic,strong)dispatch_source_t timer;

@end

@implementation LoginController2

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    self.loginer = [[IAccountLogin alloc]init];
    [self innerRequestVerifyCode];
    // Do any additional setup after loading the view from its nib.
}

- (void)initUI {
    [self.view bringSubviewToFront:self.backbtn];
    self.verifycodeNotiLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.verifycodeNotiLabel.text = [NSString stringWithFormat:@"已发送验证码至 %@",self.user.phone];
    self.loginBtn.backgroundColor = WISubmitBtnBgColor;
    self.loginBtn.clipsToBounds = YES;
    self.loginBtn.layer.cornerRadius = 22;
    [self.loginBtn setTitleColor:[UIColor colorWithHexString:@"#222222"] forState:UIControlStateNormal];
    [self.verifyBtn setTitleColor:[UIColor colorWithHexString:@"#00A1E9"] forState:UIControlStateNormal];
    self.pwdView = [WIPasswordView pwdview];
    [self.verifyCodeTtf addSubview:self.pwdView];
    [self.pwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.verifyCodeTtf);
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.pwdView resignFirstResponder];
}

- (IBAction)login:(id)sender {
    self.user.verifyCode = [self.pwdView.password copy];
    __weak typeof(self)wself = self;
    [self.loginer registerUser:self.user complete:^(WINetResponse *response) {
        if (response.success) {
            if (wself.timer) {
                dispatch_cancel(wself.timer);
            }
            [AccountManager shared].closeCountDown = YES;
            WIUser *user = [[WIUser alloc]initWithDictionary:response.obj error:nil];
            [[AccountManager shared]saveUserInfo:user];
            [AccountManager shared].user = user;
            [[NSNotificationCenter defaultCenter]postNotificationName:WILoginSuccessNoti object:nil];
            [NavManager dismissLoginController:wself];

        } else {
           
        }
    }];
}

- (IBAction)requestVerfiyCode:(id)sender {
    [self.loginer requestVerifyCode:self.user complete:^(WINetResponse *response) {
        if (response.success) {
            [Dialog simpleToast:LoginVerifySendSuccess];
            [[AccountManager shared]countDown:^(NSInteger timeout) {
                __weak typeof(self)wself = self;
                [wself updateVerfiyBtnUI:timeout];
            }];
        } else {
            [Dialog simpleToast:response.msg];
        }
    }];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)innerRequestVerifyCode {
//    if ([AccountManager shared].verifyCodeSecond > 10) {
        [self openCountDown:60];
//    }
}

#pragma mark -- 验证码按钮倒计时逻辑
- (void)openCountDown:(NSInteger )timeout {
    __block NSInteger time = timeout;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    self.timer = _timer;
    dispatch_source_set_event_handler(_timer, ^{
        if(time <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                __weak typeof(self)wself = self;
                [wself updateVerfiyBtnUI:time];
            });
            
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮显示读秒效果
                __weak typeof(self)wself = self;
                [wself updateVerfiyBtnUI:time];
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

- (void)updateVerfiyBtnUI:(NSInteger)timeout {
        if ( timeout <= 0) {
            [self.verifyBtn setTitle:@"重新获取" forState:UIControlStateNormal];
            self.verifyBtn.userInteractionEnabled = YES;
        } else {
            [self.verifyBtn setTitle:[NSString stringWithFormat:@"%lds",timeout] forState:UIControlStateNormal];
            self.verifyBtn.userInteractionEnabled = NO;
        }
}

- (void)dealloc {
    if (self.timer) {
        dispatch_source_set_event_handler(self.timer, ^{
        });
        dispatch_source_cancel(_timer);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
