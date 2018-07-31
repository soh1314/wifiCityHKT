//
//  ML_Button.m
//  ML_Button
//
//  Created by Mac mini on 2017/3/13.
//  Copyright © 2017年 MaLi. All rights reserved.
//

#import "ML_Button.h"


/**
 *  图标在上，文本在下按钮的图文间隔比例（0-1），默认0.8
 */
#define ml_buttonTopRadio 0.8
/**
 *  图标在下，文本在上按钮的图文间隔比例（0-1），默认0.5
 */
#define ml_buttonBottomRadio 0.5

#define ml_padding 8
#define ml_btnRadio 0.6

//    获得按钮的大小
#define ml_btnWidth self.bounds.size.width
#define ml_btnHeight self.bounds.size.height
//    获得按钮中UILabel文本的大小
#define ml_labelWidth self.titleLabel.bounds.size.width
#define ml_labelHeight self.titleLabel.bounds.size.height
//    获得按钮中image图标的大小
#define ml_imageWidth self.imageView.bounds.size.width
#define ml_imageHeight self.imageView.bounds.size.height


@implementation ML_Button

+ (instancetype)ml_shareButton {
    return [[self alloc] init];
}

- (void)setStatus:(MLAlignmentStatus)status {
    _status = status;
}

- (void)setMl_imageAligmentLeft:(BOOL)ml_imageAligmentLeft {
    _ml_imageAligmentLeft = ml_imageAligmentLeft;
}

#pragma mark - 左对齐
- (void)alignmentLeft{
    
    CGRect imageFrame = self.imageView.frame;
    CGRect titleFrame = self.titleLabel.frame;
    
    if (_ml_imageAligmentLeft) {
        
        imageFrame.origin.x = ml_padding;
        titleFrame.origin.x = CGRectGetWidth(imageFrame) + ml_padding + ml_padding;
    }
    else {
        titleFrame.origin.x = ml_padding;
        imageFrame.origin.x = CGRectGetWidth(titleFrame) + ml_padding + ml_padding;
    }
    
    self.imageView.frame = imageFrame;
    self.titleLabel.frame = titleFrame;
}


#pragma mark - 右对齐
- (void)alignmentRight{

    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSFontAttributeName] = self.titleLabel.font;
    CGRect frame = [self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictM context:nil];
    
    CGRect imageFrame = self.imageView.frame;
    CGRect titleFrame = self.titleLabel.frame;
    
    if (_ml_imageAligmentLeft) {
        titleFrame.origin.x = self.bounds.size.width - frame.size.width - ml_padding;
        imageFrame.origin.x = titleFrame.origin.x - ml_imageWidth - ml_padding;
    }
    else {
        imageFrame.origin.x = self.bounds.size.width - ml_imageWidth - ml_padding;
        titleFrame.origin.x = imageFrame.origin.x - frame.size.width - ml_padding;
    }
    
    self.titleLabel.frame = titleFrame;
    self.imageView.frame = imageFrame;
}

#pragma mark - 居中对齐
- (void)alignmentCenter{
    //    设置文本的坐标
    CGFloat labelX = (ml_btnWidth - ml_labelWidth -ml_imageWidth - ml_padding) * 0.5;
    CGFloat labelY = (ml_btnHeight - ml_labelHeight) * 0.5;
    
    //    设置label的frame
    self.titleLabel.frame = CGRectMake(labelX, labelY, ml_labelWidth, ml_labelHeight);
    
    //    设置图片的坐标
    CGFloat imageX = CGRectGetMaxX(self.titleLabel.frame) + ml_padding;
    CGFloat imageY = (ml_btnHeight - ml_imageHeight) * 0.5;
    //    设置图片的frame
    self.imageView.frame = CGRectMake(imageX, imageY, ml_imageWidth, ml_imageHeight);
}

#pragma mark - 图标在上，文本在下(居中)
- (void)alignmentTop{
    // 计算文本的的宽度
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSFontAttributeName] = self.titleLabel.font;
    CGRect frame = [self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictM context:nil];
    
    CGFloat imageX = (ml_btnWidth - ml_imageWidth) * 0.5;
    self.imageView.frame = CGRectMake(imageX, ml_btnHeight * 0.5 - ml_imageHeight * ml_buttonTopRadio, ml_imageWidth, ml_imageHeight);
    self.titleLabel.frame = CGRectMake((self.center.x - frame.size.width) * 0.5, ml_btnHeight * 0.5 + ml_labelHeight * ml_buttonTopRadio, ml_labelWidth, ml_labelHeight);
    CGPoint labelCenter = self.titleLabel.center;
    labelCenter.x = self.imageView.center.x;
    self.titleLabel.center = labelCenter;
}

#pragma mark - 图标在下，文本在上(居中)
- (void)alignmentBottom{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    // 计算文本的的宽度
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSFontAttributeName] = self.titleLabel.font;
    CGRect frame = [self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictM context:nil];
    
    CGFloat imageX = (ml_btnWidth - ml_imageWidth) * 0.5;
    self.titleLabel.frame = CGRectMake((self.center.x - frame.size.width) * 0.5, ml_btnHeight * 0.5 - ml_labelHeight * (1 + ml_buttonBottomRadio), ml_labelWidth, ml_labelHeight);
    self.imageView.frame = CGRectMake(imageX, ml_btnHeight * 0.5 , ml_imageWidth, ml_imageHeight);
    CGPoint labelCenter = self.titleLabel.center;
    labelCenter.x = self.imageView.center.x;
    self.titleLabel.center = labelCenter;
}

/**
 *  布局子控件
 */
- (void)layoutSubviews{
    [super layoutSubviews];
    // 判断
//    if (_status == FLAlignmentStatusNormal) {
//        
//    }
    if (_status == MLAlignmentStatusLeft){
        [self alignmentLeft];
    }
    else if (_status == MLAlignmentStatusCenter){
        [self alignmentCenter];
    }
    else if (_status == MLAlignmentStatusRight){
        [self alignmentRight];
    }
    else if (_status == MLAlignmentStatusTop){
        [self alignmentTop];
    }
    else if (_status == MLAlignmentStatusBottom){
        [self alignmentBottom];
    }
}

@end
