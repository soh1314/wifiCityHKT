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
    if (news.is_hot) {
        self.tagView.hidden = NO;
        self.tagView.text = @"热点";
        [self.tagView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(25.0f);
        }];
    } else {
        self.tagView.hidden = YES;
        [self.tagView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0.0f);
        }];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
