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
@end
