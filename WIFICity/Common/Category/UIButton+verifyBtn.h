//
//  UIButton+verifyBtn.h
//  TRGFShop
//
//  Created by yangqing Liu on 2017/10/18.
//  Copyright © 2017年 trgf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
@interface UIButton (verifyBtn)

-(void)openCountdown;
-(void)openCountdown1:(UIColor *)color; // 60s倒计时
-(void)openCountdown:(NSInteger)timeout;

- (void)setBorderAndClips;
- (void)setEasyUnable;
- (void)setEasyEnabel;

@end
