//
//  CompanyDetailSectionOne.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/4.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "CompanyDetailSectionOne.h"
#import "WIUtil.h"

@implementation CompanyDetailSectionOne

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initUI];
    // Initialization code
}

- (void)initUI {
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    self.companyNameLabel.textColor = [UIColor colorWithHexString:@"#141414"];
    self.updateTimeLabel.textColor = [UIColor colorWithHexString:@"#888888"];
    self.bossNameLabel.textColor = [UIColor colorWithHexString:@"#0079FF"];
    self.registerMoneyLabel.textColor = [UIColor colorWithHexString:@"#141414"];
    self.startTimeLabel.textColor = [UIColor colorWithHexString:@"#141414"];
    self.phoneValueLabel.textColor = [UIColor colorWithHexString:@"#888888"];
    self.addressValueLabel.textColor = [UIColor colorWithHexString:@"#888888"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setInfo:(WICompanyInfo *)info {
    _info = info;
    self.companyNameLabel.text = [info.com_name copy];
    self.phoneValueLabel.text = [info.com_tel copy];
    self.addressValueLabel.text = [info.com_address copy];
    NSString *url = [NSString stringWithFormat:@"%@/%@",kUrlHost,self.info.com_logo];
    [self.companyIcon sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
}

- (IBAction)callCompany:(id)sender {
    
    [WIUtil callPhone:self.info.phoneNumber];
}

- (IBAction)locateCompany:(id)sender {
}
@end
