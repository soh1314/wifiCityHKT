//
//  WICommentView.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/16.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WICommentView : UIView<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *commentTextView;

@property (weak, nonatomic) IBOutlet UIButton *commentBtn;

@end
