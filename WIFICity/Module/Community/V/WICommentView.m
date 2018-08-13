//
//  WICommentView.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/16.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WICommentView.h"
#import "NSString+EaseEmoji.h"
@implementation WICommentView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"WICommentView" owner:self options:nil] lastObject];
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.userInteractionEnabled = YES;
    self.inputViewMinHeight = 40;
    self.inputViewMaxHeight = 120;
    [self.commentTextView becomeFirstResponder];
    [self unActiveBtn];
    self.commentTextView.delegate = self;
    [self.commentBtn addTarget:self action:@selector(commit:) forControlEvents:UIControlEventTouchUpInside];
    _previousTextViewContentHeight = [self _getTextViewContentH:self.commentTextView];
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = @"发表您的观点...";
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    [placeHolderLabel sizeToFit];
    [self.commentTextView addSubview:placeHolderLabel];
    self.commentTextView.font = [UIFont systemFontOfSize:14.f];
    placeHolderLabel.font = [UIFont systemFontOfSize:14.f];
    [self.commentTextView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    self.commentTextView.tintColor = [UIColor blackColor];

}

- (void)setSuperViewGesture:(UIView *)view {
    UITapGestureRecognizer *tapSuperView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissView:)];
    [view addGestureRecognizer:tapSuperView];
}

- (void)dismissView:(UITapGestureRecognizer *)tap {
    if (self.dismissBlock) {
        self.dismissBlock();
    }
}

- (void)commit:(id)sender {
    weakself;
    if ([self.commentTextView.text isEqualToString:@""] || !self.commentTextView.text) {
        return;
    }
    NSString *string = [self.commentTextView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (!string || [string isEqualToString:@""]) {
        [Dialog toastCenter:@"输入文字不能全是空格"];
        return;
    }
    if (self.commentTextView.text) {
        NSString *commitTextEncode = [self.commentTextView.text stringByReplacingEmojiUnicodeWithCheatCodes];
        NSString *commitText = [self.commentTextView.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        if (commitTextEncode.length >= 500) {
            [Dialog simpleToast:@"评论字数超过限制"];
            return;
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(commentCompany:comment:complete:)]) {
            WIComment *comment = [WIComment new];
            comment.dis_content = [commitText copy];
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
    self.commentBtn.layer.cornerRadius = 6;
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


- (CGFloat)_getTextViewContentH:(UITextView *)textView
{
    
    return ceilf([textView sizeThatFits:textView.frame.size].height);
    
}

#pragma mark - textview delegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        
        return NO;
    }
    
    [self _willShowInputTextViewToHeight:[self _getTextViewContentH:self.commentTextView]];
    return YES;
}

- (void)_willShowInputTextViewToHeight:(CGFloat)toHeight
{
    if (toHeight < self.inputViewMinHeight) {
        toHeight = self.inputViewMinHeight;
    }
    if (toHeight > self.inputViewMaxHeight) {
        toHeight = self.inputViewMaxHeight;
    }
    
    if (toHeight == _previousTextViewContentHeight)
    {
        return;
    }
    else{
        CGFloat changeHeight = toHeight - _previousTextViewContentHeight;
        CGRect rect = self.frame;
        rect.size.height += changeHeight;
        [self.commentTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(rect.size.height - 16);
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(self).mas_offset(10);
            make.right.mas_equalTo(self.commentBtn.mas_left).mas_offset(-10);
        }];
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(self.superview);
            make.height.mas_equalTo(rect.size.height);
        }];

        [self.commentBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).mas_offset(-10);
            make.centerY.mas_equalTo(self);
            make.width.mas_equalTo(75);
            make.height.mas_equalTo(30);
        }];
        
        _previousTextViewContentHeight = toHeight;
        
    }
}

@end
