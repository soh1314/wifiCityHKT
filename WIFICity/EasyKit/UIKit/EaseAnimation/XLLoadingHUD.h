//
//  XLLoadingHUD.h
//  XLPaymentHUDExample
//
//  Created by MengXianLiang on 2017/4/6.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLLoadingHUD : UIView

-(void)start;

-(void)hide;

+(XLLoadingHUD*)showIn:(UIView*)view;

+(XLLoadingHUD*)hideIn:(UIView*)view;

@end
