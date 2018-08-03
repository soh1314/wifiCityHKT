

#import <Foundation/Foundation.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "SVProgressHUD.h"

@interface Dialog : NSObject<MBProgressHUDDelegate> {
	MBProgressHUD *HUD;
    
	long long expectedLength;
	long long currentLength;
}

+ (Dialog *)Instance;

//提示对话框
+ (void)alert:(NSString *)message;
+ (void)alertWithTitle:(NSString *)title andMessage:(NSString *)message;
//类似于Android一个显示框效果
+ (void)toast:(UIViewController *)controller withMessage:(NSString *) message;
+ (void)toast:(NSString *)message;
+ (void)simpleToast:(NSString *)message;
//显示在屏幕中间
+ (void)toastCenter:(NSString *)message;
//显示气泡旋转图
+ (void)showBubbleLoadingView:(UIView *)view;
//显示环形旋转图
+ (void)showRingLoadingView:(UIView *)view;
//带进度条
+ (void)progressToast:(NSString *)message;


//带遮罩效果的进度条
- (void)gradient:(UIViewController *)controller seletor:(SEL)method;

//显示遮罩
- (void)showProgress:(UIViewController *)controller;

//关闭遮罩
- (void)hideProgress;

//带说明的进度条
- (void)progressWithLabel:(UIViewController *)controller seletor:(SEL)method;

//显示带说明的进度条
- (void)showProgress:(UIViewController *)controller withLabel:(NSString *)labelText;
- (void)showCenterProgressWithLabel:(NSString *)labelText;

//显示菊花图
+ (void)showWindowToast;

//隐藏toast
+ (void)hideToastView:(UIView *)view;
+ (void)hideWindowToast;
+ (void)hideSimpleToast;

// toast某种状态
+ (void)showPogress:(NSString *)status;

@end
