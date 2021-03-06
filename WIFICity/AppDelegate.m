//
//  AppDelegate.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/11.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "AppDelegate.h"
#import "SDKConfig.h"
#import "WelcomViewController.h"
#import "WIFISevice.h"
#import "WIFIValidator.h"
#import "WIFIPusher.h"
#import "NSString+Additions.h"
#import "WebViewController.h"
#import "WIFIValidator.h"
#import "EasyCLLocationManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
     _tabBarController = [[TGTabBarController alloc]init];
    [[AccountManager shared]loadUserAccount];
    [SDKConfig configMobShare];
    [self setMainView];
    [WIFISevice shared];
    [[EasyCLLocationManager shared]requestLocateService];
    [self.window makeKeyAndVisible];
    [[UIApplication sharedApplication]setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    return YES;
}

- (void)setMainView {
    WelcomViewController *staticGuide = [[WelcomViewController alloc]init];
    UINavigationController *staticNavi = [[UINavigationController alloc]initWithRootViewController:staticGuide];
    self.window.rootViewController = staticNavi;
}

- (void)showTabController {
    [NavManager setWindowRootController:_tabBarController];
    [[UITextField appearance] setTintColor:[UIColor blackColor]];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[UIApplication sharedApplication]setApplicationIconBadgeNumber:0];
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"后台请求数据");
    [self refereshBackGroundFetch];
}

- (void)refereshBackGroundFetch {
    [WIFIPusher availabel8SendExpireValidatePush:1];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"应用退出后台");
    
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
