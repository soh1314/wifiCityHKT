//
//  WIPopView.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/27.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WIPopView.h"
#import "IEnterPrise.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
@implementation WIPopView

+ (void)popBindPhoneView:(UIViewController *)context {
    context.zh_popupController = [[zhPopupController alloc]init];
    BindPhoneView *phoneView = [[BindPhoneView alloc]initWithFrame:CGRectMake(0, 0, 300, 65)];
    [phoneView.inputPhoneView.phoneTtf becomeFirstResponder];
    __weak typeof(context)wself = context;
    phoneView.closeBlock = ^{
        [wself.zh_popupController dismiss];
    };
    
    [context.zh_popupController setMaskAlpha:0.5];
    [context.zh_popupController presentContentView:phoneView duration:0.5 springAnimated:YES];
}

+ (WICommentView *)popCommentView:(UIViewController *)context {
    context.zh_popupController = [zhPopupController popupControllerWithMaskType:zhPopupMaskTypeClear];
    context.zh_popupController.layoutType = zhPopupLayoutTypeBottom;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCREENW, 120)];
    WICommentView *commentView = [[WICommentView alloc]initWithFrame:CGRectMake(0, 0, KSCREENW, 120)];
    [view addSubview:commentView];
    [commentView setSuperViewGesture:view];
    [commentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(view);
        make.height.mas_equalTo(50);
    }];
     __weak typeof(context)wself = context;;
    commentView.dismissBlock = ^{
        [wself.zh_popupController dismiss];
    };
    [context.zh_popupController presentContentView:view duration:0.35 springAnimated:YES];
    context.zh_popupController.willDismiss = ^(zhPopupController * _Nonnull popupController) {
        [commentView.commentTextView resignFirstResponder];
    };
    return commentView;
}

@end
