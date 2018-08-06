//
//  WifiSpeedView.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/8/6.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WifiSpeedView.h"

@implementation WifiSpeedView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"WifiSpeedView" owner:self options:nil] lastObject];
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
}

@end
