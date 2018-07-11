//
//  UIScrollView+SpringRefreshHeader.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/11.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EasySpringRefreshHeader;

@interface UIScrollView (SpringRefreshHeader)

@property (strong, nonatomic) EasySpringRefreshHeader *es_header;

@end
