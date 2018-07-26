//
//  WifiListCell.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/25.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WifiListCell.h"

@implementation WifiListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initUI];
    // Initialization code
}

- (void)initUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setInfo:(WIFIInfo *)info {
    _info = info;
    self.wifiNameLabel.text = [self.info.sid copy];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
