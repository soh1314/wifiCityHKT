//
//  WICousalItemView.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/18.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WICousalItemView.h"

@implementation WICousalItemView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.iconView = [UIImageView new];
    self.iconView.frame = self.bounds;
    self.iconView.backgroundColor = randomColor;
    [self addSubview:self.iconView];
    self.iconView.contentMode = UIViewContentModeScaleAspectFill;
}

@end
