//
//  EasyTableViewFooter.m
//  TRGFShop
//
//  Created by yangqing Liu on 2017/10/26.
//  Copyright © 2017年 trgf. All rights reserved.
//

#import "EasyTableViewFooter.h"

@implementation EasyTableViewFooter

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self addSubview:self.endLabel];
    [self maslayout];
    [self setUIStyle];
}

- (void)maslayout {
    [self.endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
//        make.width.mas_equalTo(28.0);
    }];
}

- (void)setUIStyle {
//    self.endLabel.font = [UIFont systemFontOfSize:16];
//    self.endLabel.textColor = [UIColor colorWithHexString:@"#D9D9D9"];
//    self.endLabel.text = @"End";
    self.endLabel.image = [UIImage qsImageNamed:@"end"];
    self.backgroundColor = [UIColor whiteColor];
}

#pragma mark - lazy load

- (UIImageView *)endLabel
{
    if(!_endLabel)
    {
        _endLabel=[[UIImageView alloc]init];
    }
    return _endLabel;
}


@end
