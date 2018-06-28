//
//  WIButton.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/27.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WIButton.h"

@implementation WIButton

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event {
    CGRect bounds = self.bounds;
    CGFloat widthDelta = 44.0 - bounds.size.width;
    CGFloat heightDelta = 44.0 - bounds.size.height;
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    return CGRectContainsPoint(bounds, point);
    
}

@end
