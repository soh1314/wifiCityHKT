//
//  WICommentBottomBar.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/13.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WICommentBottomBar.h"
#import "WIPopView.h"

@implementation WICommentBottomBar

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"WICommentBottomBar" owner:self options:nil] lastObject];
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.commentBgView.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
    self.commentBgView.clipsToBounds = YES;
    self.commentBgView.layer.cornerRadius = 14;
    self.commentBgView.layer.borderWidth = 1;
    self.commentBgView.layer.borderColor = [UIColor colorWithHexString:@"#E3E3E3"].CGColor;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCommentBgView:)];
    [self.commentBgView addGestureRecognizer:tap];
    self.lineView.backgroundColor = [UIColor colorWithHexString:@"#E3E3E3"];
    [self.likeBtn setUnPressImageName:@"snap_default"];
    [self.likeBtn setPressImageName:@"snap"];
    self.likeBtn.selected = NO;
    self.dispatch = [IEnterPrise new];
}

- (void)setInfo:(WICompanyInfo *)info {
    _info = info;
    if (self.info.like_id) {
        self.like = YES;
        [self.likeBtn setImage:[UIImage qsImageNamed:@"snap"] forState:UIControlStateNormal];
    } else {
        self.like = NO;
        [self.likeBtn setImage:[UIImage qsImageNamed:@"snap_default"] forState:UIControlStateNormal];
    }
    [self.likeBtn setTitle:[NSString stringWithFormat:@" %ld",info.likes] forState:UIControlStateNormal];
    
    
}

- (void)setCommentNum:(NSInteger)commentNum {
    _commentNum = commentNum;
    if (_commentNum == 0) {
        [self.collectBtn setTitle:@"" forState:UIControlStateNormal];
        return;
    }
    [self.collectBtn setTitle:[NSString stringWithFormat:@" %ld",self.commentNum] forState:UIControlStateNormal];
}

- (void)tapCommentBgView:(UITapGestureRecognizer *)gesture {
    if (self.tapBlock) {
        self.tapBlock();
    }
}


- (IBAction)like:(id)sender {
    if (!self.like) {
        self.like = YES;
        weakself;
        [self.dispatch likeCompany:self.info complete:^(WINetResponse *response) {
            NSInteger likes = wself.info.likes + 1;
            [wself.likeBtn setTitle:[NSString stringWithFormat:@" %ld",likes] forState:UIControlStateNormal];
            [self.likeBtn setImage:[UIImage qsImageNamed:@"snap"] forState:UIControlStateNormal];
        }];
    } else {
        [Dialog simpleToast:@"当前企业已点赞"];
    }

}
@end
