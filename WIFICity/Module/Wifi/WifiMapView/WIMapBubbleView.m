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
    if (self.location) {
        self.distanceLabel.text = [NSString stringWithFormat:@"距您%.fm",[self calulateDistance:info]];
    } else {
        self.distanceLabel.text = @"未知";
    }
    
    
}

- (void)setLocation:(CLLocation *)location {
    _location = location;
}

- (float)calulateDistance:(WIGeometryInfo *)model {

    if (self.location) {
        CLLocation *before=[[CLLocation alloc] initWithLatitude:[model.latitude doubleValue] longitude:[model.longitude doubleValue]];
        CLLocationDistance meters=[self.location distanceFromLocation:before];
        return meters;
    }

    return 0;

}

@end
