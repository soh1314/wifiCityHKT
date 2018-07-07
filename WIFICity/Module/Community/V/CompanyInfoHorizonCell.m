//
//  CompanyInfoHorizonCell.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/5.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "CompanyInfoHorizonCell.h"

@implementation CompanyInfoHorizonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initUI];
    // Initialization code
}

- (void)initUI {
    self.companyNameLabel.textColor = [UIColor colorWithHexString:@"#141414"];
    self.companyDesLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    self.collectLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    self.likeNumLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    self.commentNumLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    self.edgeView.backgroundColor = [UIColor colorWithHexString:@"#E3E3E3"];
    self.topEdgeView.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
     self.contentView.backgroundColor = [UIColor whiteColor];

}

- (void)setInfo:(WICompanyInfo *)info {
    _info = info;
    self.companyNameLabel.text = [info.com_name copy];
    self.companyDesLabel.text = [info.com_range copy];
    self.likeNumLabel.text  = [NSString stringWithFormat:@"%ld",info.likes];
    NSString *url = [NSString stringWithFormat:@"%@/%@",kUrlHost,info.com_logo];
    [self.companyLogo sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
}

@end
