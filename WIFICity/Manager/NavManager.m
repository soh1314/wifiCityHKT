//
//  NavManager.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/12.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "NavManager.h"
#import "LoginController.h"
#import "WebViewController.h"

@implementation NavManager

+ (BOOL)firstEnterApp {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:FirstEnterAPP]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:FirstEnterAPP];
        return YES;
    } else {
        return NO;
    }
}

+ (void)showLoginController {
    
    UIViewController* rootVC = [UIApplication sharedApplication].delegate.window.rootViewController;
    LoginController *login = [[LoginController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
    if (rootVC) {
        [rootVC presentViewController:nav animated:YES completion:nil];
    }
    
}

+ (void)dismissLoginController:(UIViewController *)context {
    if (context.navigationController ) {
        UINavigationController *nav = context.navigationController;
        [nav popToRootViewControllerAnimated:NO];
        [nav dismissViewControllerAnimated:YES completion:nil];
    }
}

+ (void)setWindowRootController:(UIViewController *)context {
    [UIApplication sharedApplication].delegate.window.rootViewController = context;
}

+ (void)pushWebViewControllerWithHtmlWord:(NSString *)pTag controller:(UIViewController *)context {
    WebViewController *web = [[WebViewController alloc]init];
    web.htmlWord = [pTag copy];
    if (context.navigationController) {
        UINavigationController *nav = context.navigationController;
        [nav pushViewController:web animated:YES];
    }
}

@end
