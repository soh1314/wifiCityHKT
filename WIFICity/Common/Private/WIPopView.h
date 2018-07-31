//
//  WIPopView.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/27.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "zhPopupController.h"
#import "BindPhoneView.h"
#import "WICommentView.h"

typedef void(^WIPopViewCommitCompleteBlock)(void);
@interface WIPopView : NSObject

+ (void)popBindPhoneView:(UIViewController *)context;

+ (WICommentView *)popCommentView:(UIViewController *)context ;

@end
