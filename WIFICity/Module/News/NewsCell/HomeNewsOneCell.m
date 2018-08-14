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
    if (news.danTu) {
        NSString *urlString = nil;
        if ([news.gxq_img_src hasPrefix:@"["]) {
            urlString = [news.gxq_img_src stringByReplacingOccurrencesOfString:@"[" withString:@""];
            urlString = [urlString stringByReplacingOccurrencesOfString:@"]" withString:@""];
        } else {
            urlString = [news.gxq_img_src copy];
        }
        NSString *url = [NSString stringWithFormat:@"%@",urlString];
        NSString *urlEncode = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [self.newsImageView sd_setImageWithURL:[NSURL URLWithString:urlEncode]];
    }
}

- (void)updateHomeNews:(HomeNews *)news {
    self.titleLabel.text = [NSString stringWithFormat:@"%@",news.title];
    self.agencyLabel.text = [NSString stringWithFormat:@"%@",news.abstracts];
    if (news.img_src) {
        NSString *url = [NSString stringWithFormat:@"%@/%@",@"http://wifi.hktfi.com",self.news.img_src];
        NSString *urlEncode = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [self.newsImageView sd_setImageWithURL:[NSURL URLWithString:urlEncode]];

    } else {
        NSString *url = [NSString stringWithFormat:@"%@/%@",kUrlHost,news.src_list];
        NSString *urlEncode = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [self.newsImageView sd_setImageWithURL:[NSURL URLWithString:urlEncode]];
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
    BOOL haveImage;
    if ([news isKindOfClass:[GaoXinNewS class]]) {
        GaoXinNewS *gaoxinNews = (GaoXinNewS *)news;
        if (gaoxinNews.gxq_img_src && ![gaoxinNews.gxq_img_src isEqualToString:@"<null>"]) {
             haveImage = YES;
        } else {
            haveImage = NO;
        }
    }
    if (self.news.img_src || self.news.src_list || haveImage) {
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
    
    if (news.is_hot || news.information_type == 3001) {
        self.tagView.hidden = NO;
        if (news.is_hot) {
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
