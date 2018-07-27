//
//  EnterPriseTagCell.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/19.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "EnterPriseTagCell.h"

@implementation EnterPriseTagCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.nameLabel = [UILabel new];
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.width.mas_equalTo(52.0);
        make.height.mas_equalTo(24.0);
    }];
    self.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 5;
    self.nameLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    self.nameLabel.font = [UIFont systemFontOfSize:12];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
}

@end
