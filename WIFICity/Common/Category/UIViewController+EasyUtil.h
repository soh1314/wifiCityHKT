//
//  UIViewController+EasyUtil.h
//  WaveLink
//
//  Created by yangqing Liu on 2017/9/8.
//  Copyright © 2017年 HearMe. All rights reserved.
//

#import <UIKit/UIKit.h>

#define   kNavPushController(target,source)      [source.navigationController pushViewController:target animated:YES]

@interface UIViewController (EasyUtil)

@property(nonatomic,strong,readonly)UINavigationController *myNavigationController;

#pragma mark - 标题
- (NSString *)easyTittle:(NSString *)project; 

#pragma mark - 导航栏颜色
- (void)setWhiteTrasluntNavBar ;

- (void)setBlackNavBar;

- (void)easySetAutoInsets:(BOOL)autoInsets;

#pragma mark -导航栏方法

- (void)addBackItem;

- (void)popAction;

- (void)goToHomeView;


@end
