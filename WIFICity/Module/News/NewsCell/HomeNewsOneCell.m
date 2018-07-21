//
//  HomeNewsOneCell.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/22.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "HomeNewsOneCell.h"

@implementation HomeNewsOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self initUI];
}

- (void)initUI {
    self.titleLabel.textColor = [UIColor colorWithHexString:@"#111111"];
    self.agencyLabel.textColor = [UIColor colorWithHexString:@"#888888"];
    self.additionLabel.textColor = [UIColor colorWithHexString:@"#888888"];
    self.tagView.clipsToBounds = YES;
    self.tagView.layer.cornerRadius = 2;
    self.tagView.layer.borderWidth = 1.0f;
    self.tagView.layer.borderColor = [UIColor colorWithHexString:@"#F9595B"].CGColor;
    self.tagView.textColor = [UIColor colorWithHexString:@"#F9595B"];
    
}

- (void)setNews:(HomeNews *)news {
    _news = news;
    self.titleLabel.text = [NSString stringWithFormat:@"%@",news.title];
    self.agencyLabel.text = [NSString stringWithFormat:@"%@",news.abstracts];
    NSString *url = [NSString stringWithFormat:@"%@/%@",kUrlHost,self.news.img_src];
    [self.newsImageView sd_setImageWithURL:[NSURL URLWithString:url]];
    if (self.news.img_src) {

        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.newsImageView.mas_left).mas_offset(-12);
            make.left.mas_equalTo(self.contentView).mas_offset(16);
            make.top.mas_equalTo(self.contentView).mas_offset(22);
        }];
        [self.newsImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.newsImageView.mas_height).multipliedBy(38/25.0f).priorityHigh();
            make.left.mas_equalTo(self.titleLabel.mas_right).mas_offset(12);
            make.right.mas_equalTo(self.contentView).mas_offset(-16);
            make.height.mas_equalTo(74.5);
        }];
    } else {
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).mas_offset(-16);
            make.top.mas_equalTo(self.contentView).mas_offset(22);
            make.left.mas_equalTo(self.contentView).mas_offset(16);
        }];
        [self.newsImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.newsImageView.mas_height).multipliedBy(38/25.0f).priorityHigh();
            make.right.mas_equalTo(self.contentView).mas_offset(-16);
            make.height.mas_equalTo(74.5);
        }];

        
    }

    if (news.is_hot) {
        self.tagView.hidden = NO;
        self.tagView.text = @"热点";
        [self.tagView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(25.0f);
        }];
        [self.agencyLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(12);
            make.left.mas_equalTo(self.tagView.mas_right).mas_offset(8.0).priorityHigh();
        }];
    } else {
        self.tagView.hidden = YES;
        [self.tagView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0.0f);
        }];
        [self.agencyLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(12);
            make.left.mas_equalTo(self.tagView.mas_right).mas_offset(0);
        }];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
