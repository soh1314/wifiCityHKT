//
//  UIButton+verifyBtn.m
//  TRGFShop
//
//  Created by yangqing Liu on 2017/10/18.
//  Copyright © 2017年 trgf. All rights reserved.
//

#import "UIButton+verifyBtn.h"

#define kverifyCountingColor [UIColor lightGrayColor]
#define kverifyUnCountingColor [UIColor blackColor]

@implementation UIButton (verifyBtn)

-(void)openCountdown{
    
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [self setTitle:@"获取验证码" forState:UIControlStateNormal];
                [self setTitleColor:kverifyUnCountingColor forState:UIControlStateNormal];
                self.layer.borderColor = kverifyUnCountingColor.CGColor;
                self.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self setTitle:[NSString stringWithFormat:@"等待(%.2d)", seconds] forState:UIControlStateNormal];
                [self setTitleColor:kverifyCountingColor forState:UIControlStateNormal];
                self.layer.borderColor = kverifyCountingColor.CGColor;
                self.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}



-(void)openCountdown:(NSInteger)timeout{
    
    __block NSInteger time = timeout; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [self setTitle:@"获取验证码" forState:UIControlStateNormal];
                [self setTitleColor:kverifyUnCountingColor forState:UIControlStateNormal];
                self.layer.borderColor = kverifyUnCountingColor.CGColor;
                self.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = (time-1) % 120;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self setTitle:[NSString stringWithFormat:@"等待(%.2d)", seconds] forState:UIControlStateNormal];
                [self setTitleColor:kverifyCountingColor forState:UIControlStateNormal];
                self.layer.borderColor = kverifyCountingColor.CGColor;
                self.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}


-(void)openCountdown1:(UIColor *)color {
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [self setTitle:@"获取验证码" forState:UIControlStateNormal];
                [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                self.layer.borderColor = kverifyUnCountingColor.CGColor;
                self.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self setTitle:[NSString stringWithFormat:@"等待(%.2d)", seconds] forState:UIControlStateNormal];
                [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                self.layer.borderColor = kverifyCountingColor.CGColor;
                self.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

- (void)setBorderAndClips {
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 4;
    self.layer.borderColor = self.titleLabel.textColor.CGColor;
    self.layer.borderWidth = 1;
}

- (void)setEasyUnable {
    self.userInteractionEnabled=NO;
    self.alpha=0.4;
}

- (void)setEasyEnabel {
    self.userInteractionEnabled=YES;
    self.alpha=1;
}

@end
