//
//  WifiPanelBottomView.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/22.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WifiPanelBottomView.h"

@implementation WifiPanelBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"WifiPanelBottomView" owner:self options:nil] lastObject];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setWifiInfo:(WIFIInfo *)wifiInfo {
    _wifiInfo = wifiInfo;
    if ([self.wifiInfo isKindOfClass:[WIFICloudInfo class]]) {
        WIFICloudInfo *info = (WIFICloudInfo *)self.wifiInfo;
        self.bandWidthLabel.text = [NSString stringWithFormat:@"%.fMB",info.bandWidth];
    }
}

@end
