//
//  UILabel+Adapter.h
//  TRGFShop
//
//  Created by yangqing Liu on 2017/9/29.
//  Copyright © 2017年 trgf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Util)


/**
 *  改变行间距
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变字间距
 */
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变行间距和字间距
 */
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;



@end
