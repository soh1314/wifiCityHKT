//
//  EasePageDelegateHelper.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/19.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <Foundation/Foundation.h>


@class EasePageController;
typedef NS_ENUM(NSInteger,EasePageSourceType) {
    EasePageSourceNewsType
};

@interface EasePageDelegateHelper : NSObject

@property (nonatomic,assign)EasePageSourceType sourceType;

- (UIViewController *)easePageController:(EasePageController *)pageController viewControllerAtIndex:(NSInteger)index;

@end
