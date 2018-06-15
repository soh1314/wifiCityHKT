//
//  WIPasswordView.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/14.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WIPasswordView.h"

@implementation WIPasswordView

+ (WIPasswordView *)pwdview {
    WIPasswordView *pwdView = [[WIPasswordView alloc] initWithFrame:CGRectMake(0, 0, 230, 48)];
    pwdView.backgroundColor = [UIColor clearColor];
    pwdView.elementCount = 4;
    pwdView.center = CGPointMake(KSCREENW/2.0, 24);
    pwdView.elementBorderColor = [UIColor colorWithHexString:@"#BFBFBF"];
    pwdView.elementSelectBorderColor = [UIColor colorWithHexString:@"#00A1E9"];
    pwdView.elementMargin = 11;
    return pwdView;
}

@end
