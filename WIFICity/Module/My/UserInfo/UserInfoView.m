//
//  UserInfoView.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/26.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "UserInfoView.h"

@implementation UserInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"UserInfoView" owner:self options:nil] lastObject];
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
}

@end
