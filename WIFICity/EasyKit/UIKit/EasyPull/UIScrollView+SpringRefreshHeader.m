//
//  UIScrollView+SpringRefreshHeader.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/11.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "UIScrollView+SpringRefreshHeader.h"
#import "EasySpringRefreshHeader.h"

@implementation UIScrollView (SpringRefreshHeader)

#pragma mark - header
static const char EasySrpingRefreshHeaderKey = '\0';
- (void)setEs_header:(EasySpringRefreshHeader *)es_header
{
    if (es_header != self.es_header) {
        // 删除旧的，添加新的
        [self.mj_header removeFromSuperview];
        [self insertSubview:es_header atIndex:0];
        
        // 存储新的
        [self willChangeValueForKey:@"es_header"]; // KVO
        objc_setAssociatedObject(self, &EasySrpingRefreshHeaderKey,
                                 es_header, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"es_header"]; // KVO
    }
}

- (EasySpringRefreshHeader *)es_header
{
    return objc_getAssociatedObject(self, &EasySrpingRefreshHeaderKey);
}


@end
