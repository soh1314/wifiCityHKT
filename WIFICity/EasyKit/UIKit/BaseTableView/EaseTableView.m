//
//  EaseTableView.m
//  TRGFShop
//
//  Created by yangqing Liu on 2017/9/6.
//  Copyright © 2017年 trgf. All rights reserved.
//

#import "EaseTableView.h"

@implementation EaseTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        if (@available(iOS 11.0, *)) {
            self.showsVerticalScrollIndicator = NO;
            self.estimatedSectionHeaderHeight = 0;
            self.estimatedSectionFooterHeight = 0;
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            self.rowHeight = UITableViewAutomaticDimension;
            self.estimatedRowHeight = 450.0f;
        }
    }
    return self;
}
@end
