//
//  WICommentBottomBar.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/13.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WICommentBottomBar : UIView

@property (weak, nonatomic) IBOutlet UIView *commentBgView;

@property (weak, nonatomic) IBOutlet UIButton *collectBtn;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
- (IBAction)collect:(id)sender;
- (IBAction)like:(id)sender;


@end
