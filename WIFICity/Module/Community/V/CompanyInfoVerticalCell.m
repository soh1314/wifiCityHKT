//
//  CompanyInfoVerticalCell.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/5.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "CompanyInfoVerticalCell.h"
#import "UILabel+Util.h"
@implementation CompanyInfoVerticalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initUI];
    // Initialization code
}

- (void)initUI {
    self.nameLabel.textColor = [UIColor colorWithHexString:@"#141414"];
    self.desLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    self.collectLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    self.commentNumLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    self.likeNum.textColor = [UIColor colorWithHexString:@"#999999"];
    self.edgeView.backgroundColor = [UIColor colorWithHexString:@"#E3E3E3"];
    self.btnEdgeView.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.companyLogo.contentMode =UIViewContentModeScaleAspectFit;
    [self.commentBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    [self.likeBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    
}

- (void)setInfo:(WICompanyInfo *)info {
    _info = info;
    self.nameLabel.text = [info.com_name copy];
    self.desLabel.text = [info.com_range copy];
    self.likeNum.text  = [NSString stringWithFormat:@"%ld",info.likes];
    NSString *url = [NSString stringWithFormat:@"%@/%@",kUrlHost,info.com_logo];
    [self.companyLogo sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
//    [UILabel changeLineSpaceForLabel:self.desLabel WithSpace:1.5];
    
}

@end
