//
//  EasePageDelegateHelper.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/19.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "EasePageDelegateHelper.h"
#import "EasePageModel.h"
#import "EasePageController.h"
#import "EasePageSubViewController.h"
@implementation EasePageDelegateHelper

- (UIViewController *)easePageController:(EasePageController *)pageController viewControllerAtIndex:(NSInteger)index {
    EasePageSubViewController *sub = [[EasePageSubViewController alloc]init];
    EasePageModel *model = [EasePageModel new];
    model.index = index;
    model.title = [NSString stringWithFormat:@"标题%ld",index];
    model.modelName = @"HomeNews";
    model.cellClass = @"HomeNewsOneCell";
    sub.pageModel = model;
    return sub;
}

@end
