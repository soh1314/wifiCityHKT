//
//  CompanyDetailCommentCell.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/24.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "CompanyDetailCommentCell.h"
#import "UILabel+Util.h"
#import "NSString+Additions.h"

@implementation CompanyDetailCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self initUI];
}

- (void)initUI {
    self.commentContentLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    self.timeLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    self.nameLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    self.avartar.clipsToBounds = YES;
    self.avartar.layer.cornerRadius = 16;
    self.nameLabel.textColor = [UIColor colorWithHexString:@"#141414"];
    self.avartar.backgroundColor = randomColor;
    [UILabel changeLineSpaceForLabel:self.commentContentLabel WithSpace:1.5];
}

- (void)setComment:(WIComment *)comment {
    _comment = comment;
    self.commentContentLabel.text = [comment.disContent stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *time = [comment.disDate timeWithTimeIntervalString:comment.disDate];
    self.timeLabel.text = [time copy];
    NSString *shortId = [self.comment.useId substringToIndex:4];
    self.nameLabel.text = [NSString stringWithFormat:@"用户%@",shortId];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
