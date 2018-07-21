//
//  EasePageController.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/19.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WMPageController.h"
#import "EasePageModel.h"

@class EasePageController;
@protocol EasePageControllerDelegate <NSObject>

- (UIViewController *)easePageController:(EasePageController *)viewController AtIndex:(NSInteger)index;

@end

@interface EasePageController : WMPageController<EasePageControllerDelegate>

@property (nonatomic,assign)NSInteger count;
@property (nonatomic,copy)NSArray *itemModel;
@property (nonatomic,weak)id <EasePageControllerDelegate>delegate;

@end
