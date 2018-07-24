//
//  EaseRefreshHeader.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/23.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

@interface EaseRefreshHeader : MJRefreshStateHeader
@property (weak, nonatomic, readonly) UIImageView *arrowView;
/** 菊花的样式 */
@property (assign, nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle;
@end
