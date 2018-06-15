//
//  AppDelegate.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/11.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WITabBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) TGTabBarController *tabBarController;
@property (strong, nonatomic) UIWindow *window;

- (void)showTabController;
- (void)setMainView;

@end

