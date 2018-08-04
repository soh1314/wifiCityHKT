//
//  NavManager.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/12.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NavManager : NSObject

+ (BOOL)firstEnterApp;

+ (void)showLoginController;

+ (void)dismissLoginController:(UIViewController *)context;

+ (void)setWindowRootController:(UIViewController *)context;

+ (void)pushWebViewControllerWithUrlString:(NSString *)pTag title:(NSString *)title controller:(UIViewController *)context;

+ (void)pushBlankViewController:(UIViewController *)context;

+ (void)pushParoWebViewController:(UIViewController *)context;

+ (void)pushBindView:(UIViewController *)context;

+ (void)pushWebViewControllerWithHtmlWord:(NSString *)html title:(NSString *)title controller:(UIViewController *)context;

+ (void)showWifiGuideController:(UIViewController *)context;

@end
