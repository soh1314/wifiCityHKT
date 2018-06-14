//
//  UIImage+base.h
//  TRGFShop
//
//  Created by 刘仰清 on 2017/9/5.
//  Copyright © 2017年 trgf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (base)

+ (UIImage *)qsImageNamed:(NSString *)name;
+ (UIImage *)qsAutoImageNamed:(NSString *)name;
+ (NSData *)reSizeImageData:(UIImage *)sourceImage maxImageSize:(CGFloat)maxImageSize maxSizeWithKB:(CGFloat) maxSize;

@end
