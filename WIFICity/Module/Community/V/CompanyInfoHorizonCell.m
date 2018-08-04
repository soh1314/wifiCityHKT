//
//  CompanyInfoHorizonCell.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/5.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "CompanyInfoHorizonCell.h"
#import "UILabel+Util.h"

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
    self.companyLogo.contentMode =UIViewContentModeScaleAspectFit;
}

- (void)setInfo:(WICompanyInfo *)info {
    _info = info;
    self.companyNameLabel.text = [info.com_name copy];
    self.companyDesLabel.text = [info.com_range copy];
    self.likeNumLabel.text  = [NSString stringWithFormat:@"%ld",info.likes];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kUrlHost,info.com_logo];
    NSString *urlEncode = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.companyLogo sd_setImageWithURL:[NSURL URLWithString:urlEncode] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    if (self.info.dis) {
        self.commentNumLabel.text = [NSString stringWithFormat:@"%ld",self.info.dis];
    } else {
        self.commentNumLabel.text = @"";
    }
    if (self.info.likes) {
        self.likeNumLabel.text = [NSString stringWithFormat:@" %ld",info.likes] ;
    } else {
        self.likeNumLabel.text = @"";
    }
    if (self.info.like_id) {
        [self.likeBtn setImage:[UIImage qsImageNamed:@"snap"] forState:UIControlStateNormal];
    } else {
        [self.likeBtn setImage:[UIImage qsImageNamed:@"snap_default"] forState:UIControlStateNormal];
    }
//    [UILabel changeLineSpaceForLabel:self.companyDesLabel WithSpace:1.5];
}


- (IBAction)comment:(id)sender {
    if (self.commentBlock) {
        self.commentBlock(self.info);
    }
}

- (IBAction)like:(id)sender {
    if (self.info.like_id) {
        [Dialog simpleToast:@"无法重复点赞"];
        return;
    }
    if (self.likeBlock) {
        self.likeBlock(self.info);
    }
}
@end
