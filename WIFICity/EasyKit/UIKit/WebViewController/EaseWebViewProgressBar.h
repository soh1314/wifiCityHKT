//
//  EaseWebViewProgressBar.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/11.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EaseWebViewProgressBar : UIView

-(instancetype)initWithFrame:(CGRect)frame lineWidth:(float)lineWidth;
@property (assign,nonatomic) float progress;
@property (nonatomic,assign)float lineWidth;

@end
