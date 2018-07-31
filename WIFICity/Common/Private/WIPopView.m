//
//  WIPopView.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/27.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WIPopView.h"
#import "IEnterPrise.h"

@implementation WIPopView

+ (void)popBindPhoneView:(UIViewController *)context {
    context.zh_popupController = [[zhPopupController alloc]init];
    BindPhoneView *phoneView = [[BindPhoneView alloc]initWithFrame:CGRectMake(0, 0, 300, 210)];
    [phoneView.inputPhoneView.phoneTtf becomeFirstResponder];
    __weak typeof(context)wself = context;
    phoneView.closeBlock = ^{
        [wself.zh_popupController dismiss];
    };
    
    [context.zh_popupController setMaskAlpha:0.5];
    [context.zh_popupController presentContentView:phoneView duration:0.5 springAnimated:YES];
}

+ (WICommentView *)popCommentView:(UIViewController *)context {
    context.zh_popupController = [[zhPopupController alloc]init];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCREENW, 160)];
    WICommentView *commentView = [[WICommentView alloc]initWithFrame:CGRectZero];
    [view addSubview:commentView];
    [commentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(view);
    }];
     __weak typeof(context)wself = context;;
    commentView.dismissBlock = ^{
        [wself.zh_popupController dismiss];
    };
    context.zh_popupController.layoutType = zhPopupLayoutTypeBottom;
    [context.zh_popupController presentContentView:view duration:0.35 springAnimated:NO];
    context.zh_popupController.willDismiss = ^(zhPopupController * _Nonnull popupController) {
        [commentView.commentTextView resignFirstResponder];
    };
    return commentView;
}

@end
