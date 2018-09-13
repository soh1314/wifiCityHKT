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
    self.nameLabel.text = [info.name copy];
    self.desLabel.text = [info.businessScope copy];
    if (self.info.likesQuantity) {
        [self.likeBtn setTitle:[NSString stringWithFormat:@" %ld",info.likesQuantity] forState:UIControlStateNormal];
    } else {
        [self.likeBtn setTitle:@"" forState:UIControlStateNormal];
    }
    if (self.info.liked) {
        [self.likeBtn setImage:[UIImage qsImageNamed:@"snap"] forState:UIControlStateNormal];
    } else {
        [self.likeBtn setImage:[UIImage qsImageNamed:@"snap_default"] forState:UIControlStateNormal];
    }
    NSString *urlEncode = [info.logoImgUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.companyLogo sd_setImageWithURL:[NSURL URLWithString:urlEncode] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    if (self.info.commentsQuantity) {
        [self.commentBtn setTitle:[NSString stringWithFormat:@" %ld",self.info.commentsQuantity] forState:UIControlStateNormal];
    } else {
        [self.commentBtn setTitle:@"" forState:UIControlStateNormal];
    }
    
//    [UILabel changeLineSpaceForLabel:self.desLabel WithSpace:1.5];
    
}



- (IBAction)like:(id)sender {
    if (self.info.liked) {
        [Dialog simpleToast:@"无法重复点赞"];
        return;
    }
    if (self.likeBlock) {
        self.likeBlock(self.info);
    }
}

- (IBAction)comment:(id)sender {

    if (self.commentBlock) {
        self.commentBlock(self.info);
    }
}
@end
