//
//  NavManager.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/12.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "NavManager.h"
#import "LoginController.h"

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

@end
