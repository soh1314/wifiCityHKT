//
//  CompanyDetailSectionOne.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/4.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "CompanyDetailSectionOne.h"
#import "WIUtil.h"
#import "NSString+Additions.h"

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
    self.registerMoneyLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    self.startTimeLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    self.phoneValueLabel.textColor = [UIColor colorWithHexString:@"#888888"];
    self.addressValueLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    self.registerNotiLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    self.startTimeNotiLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    self.bossNameNotiLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    self.websiteLabel.textColor = [UIColor colorWithHexString:@"#0078FF"];
    self.quanjingLabel.textColor = [UIColor colorWithHexString:@"#D0D0D0"];
    self.websiteTitleLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    self.phoneTitleLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    self.addressTitleLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    self.quanjinTitleLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    self.phoneValueLabel.textColor = [UIColor colorWithHexString:@"#0078FF"];
    self.websiteLabel.userInteractionEnabled = YES;
    self.phoneValueLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapPhone = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPhone:)];
    [self.phoneValueLabel addGestureRecognizer:tapPhone];
    UITapGestureRecognizer *tapWebSite = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapWebSite:)];
    [self.websiteLabel addGestureRecognizer:tapWebSite];
    
}

- (void)tapPhone:(UIGestureRecognizer *)gesture {
    [self callCompany:nil];
}

- (void)tapWebSite:(UIGestureRecognizer *)gesture {
    if (self.info.website &&self.webSiteBlock) {
        self.webSiteBlock();
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setInfo:(WICompanyInfo *)info {
    _info = info;
    self.companyNameLabel.text = [info.name copy];
    self.phoneValueLabel.text = [info.telephone copy];
    self.addressValueLabel.text = [info.address copy];
    self.websiteLabel.text = [info.website copy];
    if (info.website) {
        NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:[info.website copy]];
        NSRange range = NSMakeRange(0, content.length);
        [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineSpacing = 2;
        [content addAttribute:NSParagraphStyleAttributeName value:style range: NSMakeRange(0, content.length)];
        self.websiteLabel.attributedText = content;
    }
    
    NSString *urlEncode = [self.info.logoImgUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.companyIcon sd_setImageWithURL:[NSURL URLWithString:urlEncode] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    self.registerMoneyLabel.text = [NSString stringWithFormat:@"%ld",info.registeredCapital];
    self.bossNameLabel.text = [info.legalPerson copy];
    if (self.info.vrUrl) {
        self.quanjinTitleLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        self.quanjingLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        [self.quanjinBtn setImage:[UIImage qsImageNamed:@"panorama_detail"] forState:UIControlStateNormal];
    } else {
        self.quanjinTitleLabel.textColor = [UIColor colorWithHexString:@"#D0D0D0"];
        self.quanjingLabel.textColor = [UIColor colorWithHexString:@"#D0D0D0"];
        [self.quanjinBtn setImage:[UIImage qsImageNamed:@"panorama_default"] forState:UIControlStateNormal];
    }
    self.startTimeLabel.text = [self.info.foundingDate copy];
    self.updateTimeLabel.text = [self.info.lastUpdateTime copy];
    
}

- (IBAction)callCompany:(id)sender {
    if (!self.info.telephone) {
        [Dialog simpleToast:@"该公司暂无电话信息"];
        return;
    }
    [WIUtil callPhone:self.info.telephone];
}

- (IBAction)locateCompany:(id)sender {
    if (self.locateBlock) {
        self.locateBlock();
    }
}

- (IBAction)seeQuanJin:(id)sender {
    if (self.info.vrUrl && self.SeeQuanjinBlock) {
        self.SeeQuanjinBlock();
    }
}

- (IBAction)goToHomeWebSite:(id)sender {
    if (self.info.website && self.webSiteBlock) {
        self.webSiteBlock();
    }
}
@end
