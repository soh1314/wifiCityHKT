//
//  EaseRefreshFooter.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/23.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "EaseRefreshFooter.h"

@interface EaseRefreshFooter()

@property (weak, nonatomic) UIActivityIndicatorView *loadingView;

@end


@implementation EaseRefreshFooter

- (UIActivityIndicatorView *)loadingView
{
    if (!_loadingView) {
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        loadingView.hidesWhenStopped = YES;
        [self addSubview:_loadingView = loadingView];
    }
    return _loadingView;
}

- (void)prepare
{
    [super prepare];
    self.loadingView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    // 箭头的中心点
    CGFloat arrowCenterX = self.mj_w * 0.5;
//    if (!self.stateLabel.hidden) {
//        arrowCenterX -= self.labelLeftInset + self.stateLabel.mj_textWith * 0.5;
//    }
    CGFloat arrowCenterY = self.mj_h * 0.5;
    CGPoint arrowCenter = CGPointMake(arrowCenterX, arrowCenterY);
    
    // 圈圈
    if (self.loadingView.constraints.count == 0) {
        self.loadingView.center = arrowCenter;
    }
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    // 根据状态做事情
    if (state == MJRefreshStateIdle) {
        if (oldState == MJRefreshStateRefreshing) {
            [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
                self.loadingView.alpha = 0.0;
            } completion:^(BOOL finished) {
                self.loadingView.alpha = 1.0;
                [self.loadingView stopAnimating];
            }];
        } else {
            [self.loadingView stopAnimating];
        }
    } else if (state == MJRefreshStatePulling) {
        [self.loadingView stopAnimating];

    } else if (state == MJRefreshStateRefreshing) {
        [self.loadingView startAnimating];
    } else if (state == MJRefreshStateNoMoreData) {
        [self.loadingView stopAnimating];
    }
}


@end
