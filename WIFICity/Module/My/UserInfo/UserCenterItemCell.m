//
//  UserCenterItemCell.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/4.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "UserCenterItemCell.h"

@implementation UserCenterItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initUI];
    // Initialization code
}

- (void)initUI {
    self.itemLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    self.valueLabel.textColor = [UIColor colorWithHexString:@"#666666"];
}

- (void)setUIStyle:(NSString *)className {
    if ([className isEqualToString:@"AboutUs"]) {
        self.itemLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
