//
//  UIColor+Theme.m
//  TRGFShop
//
//  Created by 刘仰清 on 2017/9/4.
//  Copyright © 2017年 trgf. All rights reserved.
//

#import "UIColor+Theme.h"

@implementation UIColor (Theme)

+ (UIColor *)bgViewColor {
    return [UIColor groupTableViewBackgroundColor];
}

+ (UIColor *)themeColor {
    return [UIColor colorWithHexString:@"#80BD01"];
}

+ (UIColor *)themeRedColor {
    return [UIColor colorWithHexString:@"#FF3939"];
}

+ (UIColor *)themelightGrayColr {
    return [UIColor lightGrayColor];
}

+ (UIColor *)themeTableEdgeColor {
    return [UIColor colorWithHexString:@"#F6F6F6"];
}

+ (UIColor *)themeblackColor {
    return [UIColor colorWithHexString:@"#101010"];
}

+ (UIColor *)themelightGrayColr2 {
    return [UIColor colorWithHexString:@"#F6F6F6"];
}

+ (UIColor *)themeLabellightGrayColor {
    return [UIColor colorWithHexString:@"#666666"];
}

+ (UIColor *)themeSeperatorLineColor {
    return [UIColor colorWithHexString:@"#D9D9D9"];
}

+ (UIColor *)TextFieldTextColor {
    return [UIColor colorWithHexString:@"#9A9A9A"];
}

+ (UIColor *)submitBtnBgColor {
    return [UIColor colorWithHexString:@"#00A1E9"];
}

#pragma mark - hex color
+ (UIColor*) colorWithHex:(long)hexColor
{
    return [UIColor colorWithHex:hexColor alpha:1.];
}

+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity
{
    float red = ((float)((hexColor & 0xFF0000) >> 16))/255.0;
    float green = ((float)((hexColor & 0xFF00) >> 8))/255.0;
    float blue = ((float)(hexColor & 0xFF))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:opacity];
}

+ (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

@end
