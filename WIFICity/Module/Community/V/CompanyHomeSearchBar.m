//
//  CompanyHomeSearchBar.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/7.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "CompanyHomeSearchBar.h"

@implementation CompanyHomeSearchBar

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"CompanyHomeSearchBar" owner:self options:nil] lastObject];
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 5;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
}

- (void)tap:(UIGestureRecognizer *)tap {
    if (self.tapBlock) {
        self.tapBlock();
    }
}

@end
