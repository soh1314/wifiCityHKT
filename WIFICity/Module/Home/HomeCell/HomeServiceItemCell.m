//
//  HomeServiceItemCell.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/22.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "HomeServiceItemCell.h"
#import "NSString+Additions.h"

@implementation HomeServiceItemCell


- (void)setServiceData:(HomeServiceData *)serviceData {
    _serviceData = serviceData;
    NSString *encodeUrl = [serviceData.icon stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.serviceImageView sd_setImageWithURL:[NSURL URLWithString:encodeUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
       
    }];
    self.serviceNameLabel.text = [self.serviceData.name copy];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initUI];
    // Initialization code
}

- (void)initUI {
    [self.serviceImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(40);
    }];
    self.serviceNameLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    self.serviceImageView.contentMode = UIViewContentModeScaleAspectFit;
}

@end
