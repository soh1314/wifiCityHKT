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
    if ([info.signalStrength floatValue] <= 0.3) {
        self.wifiSignalImageView.image = [UIImage qsImageNamed:@"wifi_two"];
    } else if ([info.signalStrength floatValue] < 0.6) {
        self.wifiSignalImageView.image = [UIImage qsImageNamed:@"wifi_thr.png"];
    } else {
        self.wifiSignalImageView.image = [UIImage qsImageNamed:@"wifi_four.png"];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
