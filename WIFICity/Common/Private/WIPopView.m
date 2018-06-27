//
//  WIPopView.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/27.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WIPopView.h"

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

@end
