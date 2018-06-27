//
//  BindPhoneInputPwdView.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/26.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "BindPhoneInputPwdView.h"

@implementation BindPhoneInputPwdView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"BindPhoneInputPwdView" owner:self options:nil] lastObject];
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self.verifyBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];

    
}

- (void)setBindphoneModel:(BindPhoneModel *)bindphoneModel {
    _bindphoneModel = bindphoneModel;
    if (self.bindphoneModel.phone) {
       self.phoneLabel.text = [self.bindphoneModel.phone copy];
    }
    if (self.bindphoneModel.countdownTime == 0 ) {
        [self.verifyBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        self.verifyBtn.userInteractionEnabled = YES;
    } else {
        NSString *verifyStr = [NSString stringWithFormat:@"%lds后重发",self.bindphoneModel.countdownTime];
        [self.verifyBtn setTitle:verifyStr forState:UIControlStateNormal];
        self.verifyBtn.userInteractionEnabled = NO;
    }
    
}

- (IBAction)checkProtocol:(id)sender {
    self.bindphoneModel.checkProtocol = self.checkBtn.selected;
    if (self.checkBtn.selected) {
        [self.checkBtn setImage:[UIImage qsImageNamed:@""] forState:UIControlStateNormal];
    } else {
        [self.checkBtn setImage:[UIImage qsImageNamed:@""] forState:UIControlStateNormal];
    }
    
}

- (IBAction)sendVerifyCode:(id)sender {
    
}

- (IBAction)close:(id)sender {
    if (self.closeBlock) {
        self.closeBlock();
    }
    
}


@end
