//
//  WifiGuideCell.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/25.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WifiGuideCell.h"

@implementation WifiGuideCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initUI];
    // Initialization code
}

- (void)initUI {
    self.notiLabel.textColor = [UIColor colorWithHexString:@"#0078FF"];
    self.backgroundColor = [UIColor colorWithHexString:@"#E8E8E8"];
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 6;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
