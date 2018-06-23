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

+ (void)pushWebViewControllerWithHtmlWord:(NSString *)pTag controller:(UIViewController *)context;

@end
