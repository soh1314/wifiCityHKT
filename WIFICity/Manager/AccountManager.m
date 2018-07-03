//
//  AccountManager.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/12.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "AccountManager.h"
#import "AccoutDataStore.h"
#import "WITabBarController.h"
#import "SDKConfig.h"

@interface AccountManager()

@property (nonatomic,strong)AccoutDataStore *dataStore;
@property (nonatomic,strong)dispatch_source_t timer;

@end

@implementation AccountManager

+ (instancetype)shared {
    static AccountManager *manager = nil;
    static dispatch_once_t once_tokn;
    dispatch_once(&once_tokn, ^{
        manager = [[self alloc]init];
    });
    return manager;
}

+ (WIUser *)currentUser {
    AccountManager *manager = [AccountManager shared];
    WIUser *user = [manager.dataStore loadAccount];
    return user;
}

+ (APPLoginState)loginState {
    WIUser *user = [self currentUser];
    if (user) {
        return (APPLoginState)user.loginState;
    } else {
        return APPLogoutState;
    }
}

+ (void)logout {
    [MBProgressHUD showHUDAddedTo:KWINDOW animated:YES];
    [AccountManager shared].user = [[WIUser alloc]init];
    [[AccountManager shared].dataStore clearDataStore];
    [[NSURLSession sharedSession] resetWithCompletionHandler:^{}];
    [SDKConfig cancleThirdLoginAuthorize];
    TGTabBarController *tabBarController = [[TGTabBarController alloc]init];
    [NavManager setWindowRootController:tabBarController];
    [NavManager showLoginController];
    [MBProgressHUD hideAllHUDsForView:KWINDOW animated:YES];
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataStore = [[AccoutDataStore alloc]init];
        self.user = [[WIUser alloc]init];
        self.reverifyEnabled = YES;
    }
    return self;
}

- (void)handleWhenAppStart {

    if (!self.user || [self.user.userId isEqualToString:@""]) {
        [self showLoginView];
    } else {
        [[NSNotificationCenter defaultCenter]postNotificationName:WILoginSuccessNoti object:nil];
    }
}

- (void)showLoginView {
    [NavManager showLoginController];
}

#pragma mark -- 倒计时全局
- (void)setCloseCountDown:(BOOL)closeCountDown {
    _closeCountDown = closeCountDown;
    if (_closeCountDown) {
        if (self.timer) {
            dispatch_source_set_event_handler(self.timer, ^{
                
            });;
            dispatch_source_cancel(_timer);
        }
    }

}

- (void)countDown:(void(^)(NSInteger timeout))block {
    self.closeCountDown = NO;
    if (self.timer) {
        dispatch_cancel(self.timer);
    }
    __block NSInteger time = 60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    self.timer = _timer;
    dispatch_source_set_event_handler(_timer, ^{
        self.verifyCodeSecond = time;
        if(time <= 0){ //倒计时结束，关闭
            NSInteger seconds = time;
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.reverifyEnabled = YES;
                if (!self.closeCountDown && block) {
                        block(seconds);
                }
            });
            
        }else{
            NSInteger seconds = (time-1) % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                self.reverifyEnabled = NO;
                if (!self.closeCountDown && block) {
                        block(seconds);
                }
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

#pragma mark - 保存读取更新用户信息
- (void)loadUserAccount {
    WIUser *user = [AccountManager currentUser];
    self.user = user;
}

- (void)refreshUserInfo {
    
}

- (void)saveUserInfo:(WIUser *)user {
    [self.dataStore saveAccountWithAccount:user];
}


@end
