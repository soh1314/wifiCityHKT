//
//  WIMapBubbleView.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/10.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WIMapBubbleView.h"

@implementation WIMapBubbleView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"WIMapBubbleView" owner:self options:nil] lastObject];
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.wifiNameLabel.textColor = [UIColor colorWithHexString:@"#141414"];
    self.distanceLabel.textColor = [UIColor colorWithHexString:@"#0078FF"];
    
}

- (void)setInfo:(WIGeometryInfo *)info {
    _info = info;
    self.wifiNameLabel.text = [self.info.wifiName copy];

}

@end
