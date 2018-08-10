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
    self.dispatch = [IEnterPrise new];
}

- (void)initUI {
    self.commentContentLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    self.timeLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    self.nameLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    self.avartar.clipsToBounds = YES;
    self.avartar.layer.cornerRadius = 16;
    self.nameLabel.textColor = [UIColor colorWithHexString:@"#141414"];
    self.avartar.backgroundColor = randomColor;
//    [UILabel changeLineSpaceForLabel:self.commentContentLabel WithSpace:1.5];
}

- (void)setComment:(WIComment *)comment {
    _comment = comment;
    NSString *content1 = [comment.dis_content replace:@" " withString:@"%"];
    NSString *content = [content1 stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.commentContentLabel.text = [content replace:@" " withString:@""];
    NSString *time = [comment.dis_date timeStringToDay:comment.dis_date];
    self.timeLabel.text = [time copy];
//    NSString *shortId = [self.comment.use_id substringFromIndex:26];
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@",[NSString phoneAddStar:self.comment.nickname]];
    if (self.comment.wx_icon) {
        [self.avartar sd_setImageWithURL:[NSURL URLWithString:self.comment.wx_icon]];
    }
    if (self.comment.qq_icon) {
        [self.avartar sd_setImageWithURL:[NSURL URLWithString:self.comment.qq_icon]];
    }
    if (self.comment.likes) {
        [self.likeBtn setTitle:[NSString stringWithFormat:@" %ld",self.comment.likes] forState:UIControlStateNormal];
    } else {
        [self.likeBtn setTitle:@" " forState:UIControlStateNormal];
    }
    
    if (self.comment.like_id) {
        [self.likeBtn setImage:[UIImage qsImageNamed:@"snap"] forState:UIControlStateNormal];
    } else {
        [self.likeBtn setImage:[UIImage qsImageNamed:@"snap_default"] forState:UIControlStateNormal];
    }
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)likeComment:(id)sender {
    __block WIComment *comment = self.comment;
    __weak typeof(self)wself = self;
    if (self.comment.like_id) {
        [Dialog simpleToast:@"当前评论已点赞"];
        return;
    }
    [self.dispatch likeCompanyComment:self.comment complete:^(WINetResponse *response) {
        if (response && response.success) {
            comment.likes ++;
            comment.like_id =  [response.obj objectForKey:@"id"];
            [wself.likeBtn setTitle:[NSString stringWithFormat:@" %ld",self.comment.likes] forState:UIControlStateNormal];
            [wself.likeBtn setImage:[UIImage qsImageNamed:@"snap"] forState:UIControlStateNormal];
        }
    }];
}
@end
