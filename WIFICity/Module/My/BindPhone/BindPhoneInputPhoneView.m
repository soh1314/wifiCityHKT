//
//  BindPhoneInputPhoneView.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/26.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "BindPhoneInputPhoneView.h"

@implementation BindPhoneInputPhoneView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"BindPhoneInputPhoneView" owner:self options:nil] lastObject];
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.nextBtn.backgroundColor = [UIColor colorWithHexString:@"#0084FF"];
    self.nextBtn.clipsToBounds = YES;
    self.nextBtn.layer.cornerRadius = 5;
    self.phoneTtf.delegate = self;
    self.phoneTtf.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
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

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.bindphoneModel.phone = [textField.text copy];
}


- (IBAction)next:(id)sender {
    if (self.nextAction) {
        self.nextAction();
    }
}


- (IBAction)close:(id)sender {
    if (self.closeBlock) {
        self.closeBlock();
    }
}

- (void)resignTtfResponder {
    [self.phoneTtf resignFirstResponder];
}

@end
