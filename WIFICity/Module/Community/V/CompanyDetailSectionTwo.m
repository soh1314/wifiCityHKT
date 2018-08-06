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
    self.abstractLabel.numberOfLines = 0;

}

- (void)setInfo:(WICompanyInfo *)info {
    _info = info;
    self.abstractLabel.text = [info.com_introduction copy];
//    NSMutableString *m_str = [NSMutableString stringWithString:self.abstractLabel.text];
//    [m_str appendString:@"查看全部"];
//    NSMutableString *m_str1 = [NSMutableString stringWithString:info.com_introduction];
//    [m_str1 appendString:@"  收起"];
//    NSMutableAttributedString *wholeAttrStr = [[NSMutableAttributedString alloc]initWithString:[m_str copy]];
//    [wholeAttrStr addAttribute:NSLinkAttributeName value:@"查看全部" range:NSMakeRange(wholeAttrStr.length - 4, 4)];
//
//    self.abstractLabel.attributedText = wholeAttrStr;
//
//    //点击事件(label需要根据内容计算宽高，有待完善)
//    [self.abstractLabel setDidClickLinkBlock:^(MLLink *link, NSString *linkText, MLLinkLabel *label) {
//        NSLog(@"%@",linkText);
//        if ([link.linkValue isEqualToString:@"查看全部"]) {
//            label.numberOfLines = 0;
//            NSMutableAttributedString *wholeAttrStr = [[NSMutableAttributedString alloc]initWithString:[m_str1 copy]];
//            [wholeAttrStr addAttribute:NSLinkAttributeName value:@"  收起" range:NSMakeRange(wholeAttrStr.length - 4, 4)];
//            label.attributedText = wholeAttrStr;
//        } else {
//            label.numberOfLines = 3;
//            NSMutableAttributedString *wholeAttrStr = [[NSMutableAttributedString alloc]initWithString:[m_str copy]];
//            [wholeAttrStr addAttribute:NSLinkAttributeName value:@"查看全部" range:NSMakeRange(wholeAttrStr.length - 4, 4)];
//            label.attributedText = wholeAttrStr;
//        }
//    }];
    
    if (self.abstractLabel.text) {
        NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:self.abstractLabel.text];
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:1.5];
        [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [self.abstractLabel.text length])];
        [self.abstractLabel setAttributedText:attributedString1];

    }


    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
