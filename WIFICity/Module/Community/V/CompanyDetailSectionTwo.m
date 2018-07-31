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
    self.abstractLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    self.notiLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    self.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];

}

- (void)setInfo:(WICompanyInfo *)info {
    _info = info;
    self.abstractLabel.text = [info.com_range copy];
    if (self.abstractLabel.text) {
        NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:self.abstractLabel.text];
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:8];
        [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [self.abstractLabel.text length])];
        [self.abstractLabel setAttributedText:attributedString1];

    }


    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
