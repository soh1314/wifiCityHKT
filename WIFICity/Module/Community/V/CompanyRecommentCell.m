//
//  CompanyRecommentCell.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/5.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "CompanyRecommentCell.h"
#import "EasyCacheHelper.h"
#import "UILabel+Util.h"
@implementation CompanyRecommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initUI ];
    // Initialization code
}

- (void)initUI {
    self.nameLabel.textColor = [UIColor colorWithHexString:@"#141414"];
    self.desLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    
}

- (void)setCompanyInfo:(WICompanyInfo *)companyInfo {
    _companyInfo = companyInfo;
    NSString *url = [NSString stringWithFormat:@"%@/%@",kUrlHost,_companyInfo.com_logo];
//    [self.logoIcon sd_setImageWithURL:[NSURL URLWithString:url]];
    [self.logoIcon sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        float ratio = image.size.height/image.size.width;
        [EasyCacheHelper saveResponseCache:[NSNumber numberWithFloat:ratio] forKey:url];
    }];
    float ratio = [[EasyCacheHelper getResponseCacheForKey:url]floatValue];
    if (ratio) {
        [self.logoIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.logoIcon.mas_height).multipliedBy(ratio);
            make.center.mas_equalTo(self.bgIconView);
            make.left.mas_equalTo(self.bgIconView).mas_offset(5);
        }];
    }
    self.nameLabel.text = [_companyInfo.com_name copy];
    self.desLabel.text = [_companyInfo.com_range copy];
    self.logoIcon.contentMode = UIViewContentModeScaleAspectFit;
    [UILabel changeLineSpaceForLabel:self.desLabel WithSpace:6];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
