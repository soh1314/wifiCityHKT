//
//  WICommentView.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/16.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WICommentView.h"

@implementation WICommentView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"WICommentView" owner:self options:nil] lastObject];
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.commentTextView.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
    [self.commentTextView becomeFirstResponder];
    [self unActiveBtn];
    self.commentTextView.delegate = self;
    [self.commentBtn addTarget:self action:@selector(commit:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)commit:(id)sender {
    weakself;
    if (self.commentTextView.text) {
        NSString *commitText = [self.commentTextView.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        if (self.delegate && [self.delegate respondsToSelector:@selector(commentCompany:comment:complete:)]) {
            WIComment *comment = [WIComment new];
            comment.disContent = [commitText copy];
            [self.delegate commentCompany:self.info comment:comment complete:^(WINetResponse *response) {
                wself.dismissBlock();
            }];
        }
    }
}

- (void)activeBtn {
    self.commentBtn.backgroundColor = [UIColor colorWithHexString:@"#0078FF"];
    [self.commentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.commentBtn.clipsToBounds = YES;
    self.commentBtn.layer.cornerRadius = 4;
}

- (void)unActiveBtn {
    self.commentBtn.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
    [self.commentBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
}

- (void)textViewDidChange:(UITextView *)textView {
    NSString *text = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
    if (text.length > 0) {
        [self activeBtn];
    } else {
        [self unActiveBtn];
    }
}

@end
