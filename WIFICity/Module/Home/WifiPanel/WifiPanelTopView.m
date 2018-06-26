//
//  WifiPanelTopView.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/22.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WifiPanelTopView.h"

@implementation WifiPanelTopView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"WifiPanelTopView" owner:self options:nil] lastObject];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end
