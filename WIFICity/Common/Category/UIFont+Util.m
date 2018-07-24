//
//  UIFont+Util.m
//  Leting
//
//  Created by aogoogle xiege on 16/7/26.
//  Copyright © 2016年 xiege. All rights reserved.
//

#import "UIFont+Util.h"


static float scale = 1;

#define FONT_LEVEL_0    8*scale
#define FONT_LEVEL_1    10*scale
#define FONT_LEVEL_2    12*scale
#define FONT_LEVEL_3    14*scale
#define FONT_LEVEL_4    15*scale
#define FONT_LEVEL_5    16*scale
#define FONT_LEVEL_6    17*scale
#define FONT_LEVEL_7    18*scale

@implementation UIFont (Util)

+ (void)load {
    
    if (IPHONE4OR4S || IPHONE5OR5S) {
         scale = 1;
    }
    else
    {
       scale = (KRATIO+0.1);
    }
    
    
}

+ (UIFont *)convertFontSize:(NSString *)size {
    UIFont *font = [self font2];
    if ([size isEqualToString:@"large"]) {
        font = [self font4];
    } else if ([size isEqualToString:@"middle"]) {
        font = [self font2];
    } else if ([size isEqualToString:@"small"]) {
        font = [self font1];
    }
    return font;
}

+ (UIFont *)font0 {
    return [self systemFontOfSize:FONT_LEVEL_0];
}

+ (UIFont *)font1 {
    return [self systemFontOfSize:FONT_LEVEL_1];
}

+ (UIFont *)font2 {
    return [self systemFontOfSize:FONT_LEVEL_2];
}

+ (UIFont *)font3 {
    return [self systemFontOfSize:FONT_LEVEL_3];
}

+ (UIFont *)font4 {
    return [self systemFontOfSize:FONT_LEVEL_4];
}

+ (UIFont *)font5 {
    return [self systemFontOfSize:FONT_LEVEL_5];
}

+ (UIFont *)font6 {
    return [self systemFontOfSize:FONT_LEVEL_6];
}

+ (UIFont *)boldFont1 {
    return [self boldSystemFontOfSize:FONT_LEVEL_1];
}

+ (UIFont *)boldFont2 {
    return [self boldSystemFontOfSize:FONT_LEVEL_2];
}

+ (UIFont *)boldFont3 {
    return [self boldSystemFontOfSize:FONT_LEVEL_3];
}

+ (UIFont *)boldFont4 {
    return [self boldSystemFontOfSize:FONT_LEVEL_4];
}

+ (UIFont *)boldFont5 {
    return [self boldSystemFontOfSize:FONT_LEVEL_5];
}



@end
