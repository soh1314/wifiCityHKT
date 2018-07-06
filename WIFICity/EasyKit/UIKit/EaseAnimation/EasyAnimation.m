//
//  EasyAnimation.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/6.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "EasyAnimation.h"

@implementation EasyAnimation

+ (EasyAnimation *)rotate180degreeAnimation {
    CABasicAnimation * rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"]; //让其在z轴旋转
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 1.0 ];//旋转角度
    rotationAnimation.duration = 0.5; //旋转周期
    rotationAnimation.cumulative = YES;//旋转累加角度
    rotationAnimation.repeatCount = 0;
    return rotationAnimation;
}


@end
