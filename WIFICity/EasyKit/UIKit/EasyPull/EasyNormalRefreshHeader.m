//
//  EasyNormalRefreshHeader.m
//  TRGFShop
//
//  Created by yangqing Liu on 2017/10/26.
//  Copyright © 2017年 trgf. All rights reserved.
//

#import "EasyNormalRefreshHeader.h"

@implementation EasyNormalRefreshHeader

- (void)prepare
{
    [super prepare];
    //创建UIImageView
//    UIImageView *logoView = [[UIImageView alloc] init];
//    //添加图片
//    logoView.image = [UIImage imageNamed:@"logo_1@2x"];
//    //将该UIImageView添加到当前header中
//    [self addSubview:logoView];
//    self.logoView = logoView;
    
    //根据拖拽的情况自动切换透明度
    self.automaticallyChangeAlpha = YES;
    self.arrowView.hidden = YES;
    //隐藏时间
    self.lastUpdatedTimeLabel.hidden = YES;
    self.stateLabel.textColor = [UIColor whiteColor];
    
    //设置文字颜色
//    self.stateLabel.textColor = [UIColor redColor];
}
/**
 *  摆放子控件
 */

- (void)beginRefreshing {
    [super beginRefreshing];
    
    [self.scrollView bringSubviewToFront:self];
}


- (void)placeSubviews
{
    [super placeSubviews];
    
}



@end
