//
//  UIViewController+EasyUtil.m
//  WaveLink
//
//  Created by yangqing Liu on 2017/9/8.
//  Copyright © 2017年 HearMe. All rights reserved.
//

#import "UIViewController+EasyUtil.h"


@implementation UIViewController (EasyUtil)

+(UIViewController *)getCurrentVCWithCurrentView:(UIView *)currentView
{
    for (UIView *next = currentView ; next ; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

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

- (void)setWhiteTrasluntNavBar {
    
//    //    [self.navigationController.navigationBar setShadowImage:[self imageWithColor:[UIColor blackColor]]];
    self.navigationController.navigationBar.translucent=NO;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.navigationController.navigationBar.alpha = 1;
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];


}

- (void)setBlackNavBar {
   
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent= NO;
     self.navigationController.navigationBar.alpha = 1;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
     [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];

}


- (void)easySetAutoInsets:(BOOL)autoInsets {
    if (!KSysVersionUP11) {
        self.automaticallyAdjustsScrollViewInsets = autoInsets;
    }  else {
       
    }
}

- (void)addBackItem {

    if (self.navigationController&&self.navigationController.viewControllers && self.navigationController.viewControllers.count >=2) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popAction)];
//        [item setWidth:40];
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
