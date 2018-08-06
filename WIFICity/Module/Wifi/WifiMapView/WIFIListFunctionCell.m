//
//  WIFIListFunctionCell.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/25.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WIFIListFunctionCell.h"

@implementation WIFIListFunctionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self initUI];
    // Initialization code
}

- (void)initUI {
    UITapGestureRecognizer *tapWifiMap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapWifiMap:)];
    [self.wifimapBgView addGestureRecognizer:tapWifiMap];
    UITapGestureRecognizer *tapSpeedTest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSpeedTest:)];
    [self.speedTestBgView addGestureRecognizer:tapSpeedTest];
    UITapGestureRecognizer *tapSaftyTest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSaftyTest:)];
    [self.saftyTestBgView addGestureRecognizer:tapSaftyTest];
    
}

- (void)tapSpeedTest:(id)sender {
    if (self.tapSpeedTestBgViewBlock) {
        self.tapSpeedTestBgViewBlock();
    }
}

- (void)tapSaftyTest:(id)sender {
    if (self.tapSaftyTestBgViewwBlock) {
        self.tapSaftyTestBgViewwBlock();
    }
}

- (void)tapWifiMap:(id)sender {
    if (self.tapWifiMapBgViewBlock) {
        self.tapWifiMapBgViewBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
