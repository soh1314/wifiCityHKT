//
//  UIScrollView+SpringHead.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/28.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SpringHeadViewHeight 200
@interface UIScrollView (SpringHead)<UIScrollViewDelegate>

@property (nonatomic, weak) UIView *topView;
- (void)addSpringHeadView:(UIView *)view;

@end

