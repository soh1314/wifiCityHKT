//
//  CompanyDetailRecruitCell.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/24.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "CompanyDetailRecruitCell.h"

@implementation CompanyDetailRecruitCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initUI];
    // Initialization code
}

- (void)initUI {
    self.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    self.arrowLabel.textColor = [UIColor colorWithHexString:@"#F1F1F1"];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    
}

- (void)setInfo:(WICompanyInfo *)info {
    _info = info;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
