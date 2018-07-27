//
//  UILabel+Adapter.m
//  TRGFShop
//
//  Created by yangqing Liu on 2017/9/29.
//  Copyright © 2017年 trgf. All rights reserved.
//

#import "UILabel+Util.h"
#import <objc/runtime.h>
@implementation UILabel (Util)

+ (void)load {
    Method method1 = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method method2 = class_getInstanceMethod([self class], @selector(qsAdapterinitWithCoder:));
    method_exchangeImplementations(method1, method2);
}

- (instancetype)qsAdapterinitWithCoder:(NSCoder *)aDecoder {
    [self qsAdapterinitWithCoder:aDecoder];
    if (self) {
        if (IPHONE4OR4S || IPHONE5OR5S) {
            self.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:self.font.pointSize*0.95];
        } else {
            if (IPHONE6PLUS) {
                self.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:self.font.pointSize+1];
            } else {
                self.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:self.font.pointSize];
            }
            
        }
       
    }
    return self;
}


+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
//    [label sizeToFit];
    
}

+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
//    [label sizeToFit];
    
}

+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
//    [label sizeToFit];
    
}


@end
