//
//  BindPhoneController.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/8/10.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "BindPhoneController.h"
#import "IAccountLogin.h"
@interface BindPhoneController ()<UITextFieldDelegate>
@property (nonatomic,strong)IAccountLogin *accountLogin;
@property (nonatomic,assign)NSInteger code;
@end

@implementation BindPhoneController

- (id)init {
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.accountLogin = [IAccountLogin new];
    [self setBlackNavBar];
    [self initUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI {
    self.commitBtn.clipsToBounds = YES;
    self.commitBtn.layer.cornerRadius = 22;
    self.phoneTtf.delegate = self;
    self.phoneTtf.clearButtonMode=UITextFieldViewModeWhileEditing;
    if (self.bindNewPhone) {
        self.title = @"更换手机号";
        [self.commitBtn setTitle:@"确认更换" forState:UIControlStateNormal];
    } else {
        self.title = @"绑定手机号";
        [self.commitBtn setTitle:@"确认绑定" forState:UIControlStateNormal];
    }
}

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

- (IBAction)requestVerifyCode:(id)sender {
    WIUser *user = [WIUser new];
    user.phone = [self.phoneTtf.text copy];
    if (!user.phone || user.phone.length <= 0) {
        [Dialog toastCenter:@"输入手机号为空"];
        return;
    }
    [self.accountLogin requestBindPhoneVerifyCode:user complete:^(WINetResponse *response) {
        if (response.success) {
            [Dialog toastCenter:@"验证码已发送"];
            self.code = response.intObj;
            NSLog(@"绑定手机号%ld",self.code);
            [self openCountDown];
        } else {
            [Dialog toastCenter:response.msg];
        }
    }];
}

- (void)openCountDown {
    __block NSInteger time = 60;
    weakself;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [wself.verifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                wself.verifyBtn.userInteractionEnabled = YES;
            });
            
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮显示读秒效果
                time--;
                NSString *verifyStr = [NSString stringWithFormat:@"%lds后重发",time];
                [wself.verifyBtn setTitle:verifyStr forState:UIControlStateNormal];
                wself.verifyBtn.userInteractionEnabled = NO;
                
            });
        }
    });
    dispatch_resume(_timer);
}

- (IBAction)bindBtn:(id)sender {
    WIUser *user = [WIUser new];
    user.phone = [self.phoneTtf.text copy];
    user.verifyCode = [self.verifyCodeTtf.text copy];
    if ([self.verifyCodeTtf.text integerValue] != self.code || self.code == 0) {
        [Dialog toastCenter:@"验证码错误"];
        return ;
    }
    [self.accountLogin bindPhone:user complete:^(WINetResponse *response) {
        if (response.success) {
            [AccountManager shared].user.phone = [user.phone copy];
            [[AccountManager shared]saveUserInfo:[AccountManager shared].user];
            [self.navigationController popViewControllerAnimated:YES];
            [Dialog simpleToast:response.msg];
            
        } else {
            [Dialog simpleToast:response.msg];
        }
    }];
}
@end
