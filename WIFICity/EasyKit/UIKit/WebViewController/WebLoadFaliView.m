//
//  WebLoadFaliView.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/9/4.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WebLoadFaliView.h"

@implementation WebLoadFaliView


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"WebLoadFaliView" owner:self options:nil] lastObject];
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.reTryBtn.clipsToBounds = YES;
    self.reTryBtn.layer.cornerRadius = 6;
    self.reTryBtn.layer.borderWidth = 1;
    self.reTryBtn.layer.borderColor = [UIColor themeColor].CGColor;
}

- (IBAction)retryLoadData:(id)sender {
    if (self.reloadBlock) {
        self.reloadBlock();
    }
}
@end
