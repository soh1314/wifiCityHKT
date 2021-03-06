//
//  CompanySortItemView.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/6.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "EaseSortItemView.h"

@implementation EaseSortItemView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.titleLabel = [UILabel new];
    [self addSubview:self.titleLabel];
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"#777777"];
    self.icon = [UIImageView new];
    self.icon.image = [UIImage qsImageNamed:@"inverted_triangle"];
    [self addSubview:self.icon];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.centerX.mas_equalTo(self);
    }];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self.titleLabel.mas_right).mas_offset(2);
    }];
}

- (void)iconRotateDown{
    [UIView animateWithDuration:0.5f animations:^{
        self.icon.transform = CGAffineTransformMakeRotation(M_PI);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)iconRotateUp {
    [UIView animateWithDuration:0.5f animations:^{
        self.icon.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
}

@end
