//
//  WICommentView.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/16.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WICommentCommitBlock)(void);

@interface WICommentView : UIView<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *commentTextView;

@property (weak, nonatomic) IBOutlet UIButton *commentBtn;

@property (nonatomic,copy)WICommentCommitBlock commit;

@end
