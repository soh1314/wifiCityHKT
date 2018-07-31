//
//  WICommentBottomBar.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/13.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DGThumbUpButton.h"
#import "WICompanyInfo.h"
typedef void(^WICommentBottomBarTapAction)(void);
@interface WICommentBottomBar : UIView

@property (weak, nonatomic) IBOutlet UIView *commentBgView;

@property (weak, nonatomic) IBOutlet UIButton *collectBtn;
@property (weak, nonatomic) IBOutlet DGThumbUpButton *likeBtn;
@property (nonatomic,copy)WICommentBottomBarTapAction tapBlock;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (nonatomic,strong)WICompanyInfo *info;


@end
