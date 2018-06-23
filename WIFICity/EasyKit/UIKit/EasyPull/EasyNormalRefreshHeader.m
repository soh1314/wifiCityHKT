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
    
    //隐藏时间
    self.lastUpdatedTimeLabel.hidden = YES;
    
    //设置文字颜色
//    self.stateLabel.textColor = [UIColor redColor];
}
/**
 *  摆放子控件
 */

- (void)placeSubviews
{
    [super placeSubviews];
    
    self.logoView.mj_x = 0;
    self.logoView.mj_w = self.mj_w;
    self.logoView.mj_h = self.mj_h;
    self.logoView.mj_y=  0;
}



@end
