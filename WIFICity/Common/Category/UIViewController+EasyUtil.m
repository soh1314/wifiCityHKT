//
//  UIViewController+EasyUtil.m
//  WaveLink
//
//  Created by yangqing Liu on 2017/9/8.
//  Copyright © 2017年 HearMe. All rights reserved.
//

#import "UIViewController+EasyUtil.h"

@implementation UIViewController (EasyUtil)

- (NSString *)easyTittle:(NSString *)project {
    NSDictionary *tytDic = @{@"TicketController":@"奖券",
                             @"CouponController":@"优惠劵",
                             @"UIViewController":@"默认",
                             @"SettingController":@"设置",
                             @"WalletController":@"钱包",
                             @"TicketController":@"抽奖券",
                             @"MessageController":@"消息",
                             @"FootPrintController":@"足迹",
                             @"WalletDetailController":@"钱包明细",
                             @"HomeController":@"首页"};
    
    NSString *controllerName = NSStringFromClass(self.class);
    return [tytDic objectForKey:controllerName];
}

- (void)setWhiteTrasluntNavBar {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
//    [self.navigationController.navigationBar setShadowImage:[self imageWithColor:[UIColor blackColor]]];
    self.navigationController.navigationBar.translucent=YES;
    self.navigationController.navigationBar.hidden = YES;
    
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 0.25f, 0.25f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

- (void)setBlackNavBar {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.translucent= NO;
}


- (void)easySetAutoInsets:(BOOL)autoInsets {
    if (!KSys11Up) {
        self.automaticallyAdjustsScrollViewInsets = autoInsets;
    }  else {
       
    }
}

- (void)addBackItem {

    if (self.navigationController&&self.navigationController.viewControllers && self.navigationController.viewControllers.count >=2) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popAction)];
        self.navigationItem.hidesBackButton = YES;
        self.navigationItem.leftBarButtonItem = item;
        self.navigationItem.backBarButtonItem = nil;
    }
}


- (void)popAction{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (UINavigationController*)myNavigationController
{
    UINavigationController* nav = nil;
    if ([self isKindOfClass:[UINavigationController class]]) {
        nav = (id)self;
    }
    else {
        if ([self isKindOfClass:[UITabBarController class]]) {
            nav = ((UITabBarController*)self).selectedViewController.myNavigationController;
        }
        else {
            nav = self.navigationController;
        }
    }
    return nav;
}

- (void)goToHomeView {
    if (self.parentViewController) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if ([window.rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tab = (UITabBarController *)window.rootViewController;
        tab.selectedIndex = 0;
    }
}





@end
