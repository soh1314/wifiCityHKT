//
//  EnterPriseSquareHomeInfoCell.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/5.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "EnterPriseSquareHomeInfoCell.h"

@implementation EnterPriseSquareHomeInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initUI];
    // Initialization code
}

- (void)initUI {
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
