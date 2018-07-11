//
//  CompanyDetailSectionTwo.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/4.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "CompanyDetailSectionTwo.h"

@implementation CompanyDetailSectionTwo

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initUI];
    // Initialization code
}

- (void)initUI {
    self.abstractLabel.textColor = [UIColor colorWithHexString:@"#141414"];
    self.edgeView.backgroundColor = [UIColor colorWithHexString:@"#0078FF"];
    self.notiLabel.textColor = [UIColor colorWithHexString:@"#0078FF"];
}

- (void)setInfo:(WICompanyInfo *)info {
    _info = info;
    self.abstractLabel.text = [info.com_range copy];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end