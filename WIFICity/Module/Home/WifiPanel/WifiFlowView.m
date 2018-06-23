//
//  WifiFlowView.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/22.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WifiFlowView.h"

@implementation WifiFlowView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"WifiFlowView" owner:self options:nil] lastObject];
        [self initUI];
        
    }
    return self;
}

- (void)initUI {
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 80;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor colorWithHexString:@"#0078FF"].CGColor;
}

- (void)setWifiInfo:(WIFIInfo *)wifiInfo {
    _wifiInfo = wifiInfo;
    if ([self.wifiInfo isKindOfClass:[WIFICloudInfo class]]) {
        WIFICloudInfo *info = (WIFICloudInfo *)self.wifiInfo;
        self.totalFlowLabel.text = [NSString stringWithFormat:@"%.2f",info.flowNumber];
        
    }
}


@end
