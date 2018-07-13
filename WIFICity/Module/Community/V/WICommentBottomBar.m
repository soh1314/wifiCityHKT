//
//  WICommentBottomBar.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/13.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WICommentBottomBar.h"

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
}

- (void)tapCommentBgView:(UITapGestureRecognizer *)gesture {
    
}

- (IBAction)collect:(id)sender {
}

- (IBAction)like:(id)sender {
}
@end
