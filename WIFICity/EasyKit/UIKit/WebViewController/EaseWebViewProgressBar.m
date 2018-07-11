//
//  EaseWebViewProgressBar.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/11.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "EaseWebViewProgressBar.h"
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

@interface EaseWebViewProgressBar()

@property (nonatomic,strong)CAShapeLayer *trackLayer;
@property (nonatomic,strong)CAShapeLayer *progressLayer;

@end

@implementation EaseWebViewProgressBar

-(instancetype)initWithFrame:(CGRect)frame lineWidth:(float)lineWidth {
    if (self = [super initWithFrame:frame]) {
        self.lineWidth = lineWidth;
        [self initUI];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    UIBezierPath *linePathpath = [UIBezierPath new];
    [linePathpath moveToPoint:CGPointMake(0, self.bounds.size.height/2.0f)];
    [linePathpath addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height/2.0f)];
    
    self.trackLayer = [CAShapeLayer layer];
    self.trackLayer.frame = self.bounds;
    self.trackLayer.fillColor = [UIColor clearColor].CGColor;
    self.trackLayer.strokeColor = [UIColor clearColor].CGColor;
    self.trackLayer.path = [linePathpath CGPath];
    self.trackLayer.strokeEnd = 1;
    [self.layer addSublayer:self.trackLayer];
    
    
    //创建进度layer
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.frame = self.bounds;
    _progressLayer.fillColor =  [[UIColor clearColor] CGColor];
    _progressLayer.strokeColor  = [[UIColor blackColor] CGColor];
    _progressLayer.lineCap = kCALineCapRound;
    _progressLayer.lineWidth = self.lineWidth;
    _progressLayer.path = [linePathpath CGPath];
    _progressLayer.strokeEnd = 0;
    
    //设置渐变颜色
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    [gradientLayer setColors:[NSArray arrayWithObjects:(id)[RGB(0,60, 97) CGColor],(id)[RGB(0, 180, 197) CGColor], nil]];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    [gradientLayer setMask:_progressLayer];
    [self.layer addSublayer:gradientLayer];
    
}

-(void)setProgress:(float)progress
{
    _progress = progress;
    _progressLayer.strokeEnd = progress;
    [_progressLayer removeAllAnimations];
}


@end
