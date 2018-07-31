//
//  WICommentView.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/16.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EnterPriseDelegate.h"

typedef void(^WICommentDismissBlock)(void);

@interface WICommentView : UIView<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *commentTextView;

@property (weak, nonatomic) IBOutlet UIButton *commentBtn;

@property (nonatomic,copy)WICommentDismissBlock dismissBlock;

@property (nonatomic,strong)WICompanyInfo *info;

@property (nonatomic,weak)id <EnterPriseDelegate>delegate;

@end
