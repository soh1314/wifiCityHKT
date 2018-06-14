//
//  UILabel+Adapter.m
//  TRGFShop
//
//  Created by yangqing Liu on 2017/9/29.
//  Copyright © 2017年 trgf. All rights reserved.
//

#import "UILabel+Adapter.h"
#import <objc/runtime.h>
@implementation UILabel (Adapter)

+ (void)load {
    Method method1 = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method method2 = class_getInstanceMethod([self class], @selector(qsAdapterinitWithCoder:));
    method_exchangeImplementations(method1, method2);
}

- (instancetype)qsAdapterinitWithCoder:(NSCoder *)aDecoder {
    [self qsAdapterinitWithCoder:aDecoder];
    if (self) {
        if (!IPHONE4OR4S || !IPHONE5OR5S) {
//            self.font = [UIFont systemFontOfSize:self.font.pointSize*(KRATIO-0.1)];
//            self.font.pointSize = self.font.pointSize*(KRATIO-0.1);
//            self.font = [UIFont fontWithName:self.font.fontName size:self.font.pointSize*(KRATIO-0.1)];
            self.font = [UIFont fontWithName:self.font.fontName size:self.font.pointSize];
        }
    }
    return self;
}

@end
