//
//  WifiDectectPanel.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/25.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WifiDectectPanel.h"

@implementation WifiDectectPanel

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"WifiDectectPanel" owner:self options:nil] lastObject];
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
}

- (IBAction)jumpToWifiGuide:(id)sender {
    if (self.wifiGuideBlock) {
        self.wifiGuideBlock();
    }
}

- (void)setInfo:(WIFIInfo *)info {
    _info = info;
    if (!info || !info.sid) {
        self.connectStatusLabel.text = @"当前没有连接WIFI";
        self.wifiNameLabel.text = @"";
        self.wifiSignalLabel.text = @"";
        self.wifiDelayLabel.text = @"";
    } else {
        self.connectStatusLabel.text = @"连接成功，安全保护中";
        self.wifiNameLabel.text = [info.sid copy];
        self.wifiSignalLabel.text = @"优";
        self.wifiDelayLabel.text = @"10ms";
    }
    
    
}

@end
