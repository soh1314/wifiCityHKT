//
//  BindPhoneView.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/26.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "BindPhoneView.h"

@implementation BindPhoneView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
        self.bindPhoneModel = [BindPhoneModel new];
        self.accountLogin = [IAccountLogin new];
    }
    return self;
}

- (void)initUI {
    self.inputPwdView = [[BindPhoneInputPwdView alloc]initWithFrame:self.bounds];
    self.inputPhoneView = [[BindPhoneInputPhoneView alloc]initWithFrame:self.bounds];
    [self addSubview:self.inputPwdView];
    [self addSubview:self.inputPhoneView];
    [self.inputPwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    [self.inputPhoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 4;
    self.inputPwdView.hidden = YES;
    
    __weak typeof(self)wself = self;
    self.inputPhoneView.nextAction = ^{
        wself.bindPhoneModel.phone = [wself.inputPhoneView.phoneTtf.text copy];
        [wself.inputPhoneView resignTtfResponder];
        WIUser *user = [WIUser new];
        user.phone = [wself.bindPhoneModel.phone copy];
        [wself.accountLogin requestBindPhoneVerifyCode:user complete:^(WINetResponse *response) {
            if (response.success) {
                wself.inputPwdView.hidden = NO;
                wself.inputPhoneView.hidden = YES;
                [wself openCountDown];
            }
        }];
        
    };
    self.inputPhoneView.closeBlock = ^{
        wself.closeBlock();
    };
    self.inputPwdView.closeBlock = ^{
        wself.closeBlock();
    };
    
}

- (void)openCountDown {
    __block NSInteger time = 60;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                __weak typeof(self)wself = self;
                wself.bindPhoneModel.countdownTime = time;
                [wself.inputPwdView setBindphoneModel:wself.bindPhoneModel];
            });
            
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮显示读秒效果
                __weak typeof(self)wself = self;
                wself.bindPhoneModel.countdownTime = time;
                [wself.inputPwdView setBindphoneModel:wself.bindPhoneModel];
                time--;
            });
        }
    });
    dispatch_resume(_timer);
}

@end
