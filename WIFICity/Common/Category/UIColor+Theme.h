//
//  UIColor+Theme.h
//  TRGFShop
//
//  Created by 刘仰清 on 2017/9/4.
//  Copyright © 2017年 trgf. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WITextFieldTextColor
#define WITextFieldBgTextColor [UIColor TextFieldTextColor]
#define WISepratorLineColor [UIColor TextFieldTextColor]
#define WISubmitBtnBgColor [UIColor submitBtnBgColor]
#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@interface UIColor (Theme)

+ (UIColor *)bgViewColor;

+ (UIColor *)themeColor;

+ (UIColor *)themeblackColor;

+ (UIColor *)themelightGrayColr;

+ (UIColor *)themelightGrayColr2;

+ (UIColor *)themeTableEdgeColor;

+ (UIColor *)themeRedColor;

+ (UIColor *)themeLabellightGrayColor; //一般的文本颜色

+ (UIColor *)themeSeperatorLineColor; //一般的tableview底色

+ (UIColor *)submitBtnBgColor;

+ (UIColor *)TextFieldTextColor;
// hex颜色
+ (UIColor*) colorWithHex:(long)hexColor;

+ (UIColor *) colorWithHexString: (NSString *)color;

@end
