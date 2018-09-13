//
//  HomeNewsOneCell.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/22.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "HomeNewsOneCell.h"
#import "GaoXinNewS.h"
@implementation HomeNewsOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self initUI];
}

- (void)initUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.titleLabel.textColor = [UIColor colorWithHexString:@"#111111"];
    self.agencyLabel.textColor = [UIColor colorWithHexString:@"#888888"];
    self.additionLabel.textColor = [UIColor colorWithHexString:@"#888888"];
    self.tagView.clipsToBounds = YES;
    self.tagView.layer.cornerRadius = 2;
    self.tagView.layer.borderWidth = 1.0f;
    self.tagView.layer.borderColor = [UIColor colorWithHexString:@"#F9595B"].CGColor;
    self.tagView.textColor = [UIColor colorWithHexString:@"#F9595B"];
    self.newsImageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)updateGaoXinNews:(GaoXinNewS *)news {
    self.titleLabel.text = [NSString stringWithFormat:@"%@",news.gxq_title];
    self.agencyLabel.text = [NSString stringWithFormat:@"%@",news.gxq_agency];
    if (self.news.images && self.news.images.count > 0) {
        NSDictionary *imageDic = self.news.images[0];
        [self.newsImageView sd_setImageWithURL:[NSURL URLWithString:imageDic[@"imgUrl"]]];
    }
}

- (void)updateHomeNews:(HomeNews *)news {
    self.titleLabel.text = [NSString stringWithFormat:@"%@",news.title];
    if (news.source) {
        self.agencyLabel.text = [NSString stringWithFormat:@"%@",news.source];

    }
    if (self.news.images && self.news.images.count > 0) {
        NSDictionary *imageDic = self.news.images[0];
        [self.newsImageView sd_setImageWithURL:[NSURL URLWithString:imageDic[@"imgUrl"]]];
    }

}



- (void)setNews:(HomeNews *)news {
    _news = news;
    BOOL isGaoxinNews = NO;
    if ([news isKindOfClass:[GaoXinNewS class]]) {
        [self updateGaoXinNews:(GaoXinNewS *)self.news];
        isGaoxinNews = YES;
    } else {
        [self updateHomeNews:news];
    }
    [self updateLayout:news];
}

- (void)updateLayout:(HomeNews *)news {
    if (self.news.imgType == 2) {
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.newsImageView.mas_left).mas_offset(-12);
            make.left.mas_equalTo(self.contentView).mas_offset(16);
            make.top.mas_equalTo(self.contentView).mas_offset(12).priorityHigh();
        }];
        [self.newsImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel);
            make.width.mas_equalTo(self.newsImageView.mas_height).multipliedBy(38/25.0f).priorityHigh();
            make.left.mas_equalTo(self.titleLabel.mas_right).mas_offset(12);
            make.right.mas_equalTo(self.contentView).mas_offset(-16);
            make.bottom.mas_equalTo(self.agencyLabel);
//            make.height.mas_equalTo(75);
        }];
    } else {
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).mas_offset(-16);
            make.top.mas_equalTo(self.contentView).mas_offset(12);
            make.left.mas_equalTo(self.contentView).mas_offset(16);
        }];
        [self.newsImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.top.mas_equalTo(self.titleLabel);
            make.width.mas_equalTo(0).priorityHigh();
            make.right.mas_equalTo(self.contentView).mas_offset(-16);
            make.bottom.mas_equalTo(self.agencyLabel);
//            make.height.mas_equalTo(75);
        }];
    }
    
    if (news.hot || news.information_type == 3001) {
        self.tagView.hidden = NO;
        if (news.hot) {
            self.tagView.text = @"热点";
            self.tagView.layer.borderColor = [UIColor colorWithHexString:@"#F9595B"].CGColor;
            self.tagView.textColor = [UIColor colorWithHexString:@"#F9595B"];
        } else {
            self.tagView.text = @"广告";
            self.tagView.textColor = [UIColor themeColor];
            self.tagView.layer.borderColor = [UIColor themeColor].CGColor;
        }
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
