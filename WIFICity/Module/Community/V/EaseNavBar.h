//
//  EaseNavBar.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/18.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EaseNavBar : UIView

@property (nonatomic,weak)UIScrollView *scrollView;
@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,strong)UIView *contentView;
@property (nonatomic,strong)UIImageView *bgImageView;
@property (nonatomic,weak)UIViewController *context;
@property (nonatomic,assign)float fazhi;

@end
