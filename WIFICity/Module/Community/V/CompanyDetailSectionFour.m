//
//  CompanyDetailSectionFour.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/4.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "CompanyDetailSectionFour.h"

@implementation CompanyDetailSectionFour

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initUI];
    // Initialization code
}

- (void)initUI {
    self.titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    self.recruitSubTitleLabel.textColor = [UIColor colorWithHexString:@"#141414"];
    self.websiteSubTitleLabel.textColor = [UIColor colorWithHexString:@"#141414"];
    self.productInfoSubTitleLabel.textColor = [UIColor colorWithHexString:@"#141414"];
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    self.edgeView2.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    self.egdeView1.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    
    UITapGestureRecognizer *tapRecruitMent = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapRecruitMent:)];
    [self.recruimentView addGestureRecognizer:tapRecruitMent];
    UITapGestureRecognizer *tapProductInfo = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapProductInfo:)];
    [self.productInfoView addGestureRecognizer:tapProductInfo];
    UITapGestureRecognizer *tapWebsite = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapWebsite:)];
    [self.websiteView addGestureRecognizer:tapWebsite];
}

- (void)tapRecruitMent:(id)sender {
    if (self.actionBlock) {
        self.actionBlock(self.info.website);
    }
}

- (void)tapProductInfo:(id)sender {
    if (self.actionBlock) {
        self.actionBlock(self.info.website);
    }
}

- (void)tapWebsite:(id)sender {
    if (self.actionBlock) {
        self.actionBlock(self.info.website);
    }
}

- (void)setInfo:(WICompanyInfo *)info {
    _info = info;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
