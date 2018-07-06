//
//  CompanyRecommentCell.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/5.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "CompanyRecommentCell.h"

@implementation CompanyRecommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initUI ];
    // Initialization code
}

- (void)initUI {
    self.nameLabel.textColor = [UIColor colorWithHexString:@"#141414"];
    self.desLabel.textColor = [UIColor colorWithHexString:@"#666666"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
