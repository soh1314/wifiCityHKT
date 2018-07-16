//
//  SysMacro.h
//  TRGFShop
//
//  Created by yangqing Liu on 2017/9/7.
//  Copyright © 2017年 trgf. All rights reserved.
//

#ifndef SysMacro_h
#define SysMacro_h

#define kAPPUpdateUrl @"https://itunes.apple.com/cn/app/tian-rang-gong-fang/id1079267958?mt=8"
#define kBundleId [[NSBundle mainBundle] bundleIdentifier]
#define kAPPVersion [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define kAPPBuildNO [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleVersion"]
#define kAPPDisplayName [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleDisplayName"];

#define kSysVersion [[UIDevice currentDevice].systemVersion floatValue]
#define KSys11Up    ([[UIDevice currentDevice].systemVersion floatValue] >= 11.0)
#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

//UI
#define KWINDOW [UIApplication sharedApplication].delegate.window
#define KSCREENW [UIScreen mainScreen].bounds.size.width
#define KSCREENH [UIScreen mainScreen].bounds.size.height
#define KRATIO   KSCREENW/320
#define KSCALE   [UIScreen mainScreen].scale

/**  *  1 判断是否为3.5inch      320*480  */
#define ONESCREEN ([UIScreen mainScreen].bounds.size.height == 480)
/**  *  2 判断是否为4inch        640*1136  */
#define TWOSCREEN ([UIScreen mainScreen].bounds.size.height == 568)
/**  *  3 判断是否为4.7inch   375*667   750*1334  */
#define THREESCREEN ([UIScreen mainScreen].bounds.size.height == 667)
/**  *  4 判断是否为5.5inch   414*1104   1242*2208  */
#define FOURSCREEN ([UIScreen mainScreen].bounds.size.height == 1104)
#define isIPhoneX     (KSCREENW == 375.f && KSCREENH == 812.f)
#define IPHONE4OR4S ONESCREEN
#define IPHONE5OR5S TWOSCREEN
#define IPHONE6OR6S FOURSCREEN

#define kNavBarHeight  44.0f
#define kStatusBarHeight  (isIPhoneX ? 44.0f : 20.0f)
#define KTabbarHeight  49

// 颜色
#define UIColorFromHexadecimalRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGB(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 适配11.0
#define  adjustsScrollViewInsets(scrollView)\
do {\
_Pragma("clang diagnostic push")\
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")\
if ([scrollView respondsToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
NSMethodSignature *signature = [UIScrollView instanceMethodSignatureForSelector:@selector(setContentInsetAdjustmentBehavior:)];\
NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];\
NSInteger argument = 2;\
invocation.target = scrollView;\
invocation.selector = @selector(setContentInsetAdjustmentBehavior:);\
[invocation setArgument:&argument atIndex:2];\
[invocation retainArguments];\
[invocation invoke];\
}\
_Pragma("clang diagnostic pop")\
} while (0)

#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif

#define kAppUrl(host,path) [NSString stringWithFormat:@"%@%@",host,path]
#define KINT2STR(a)  [NSString stringWithFormat:@"%ld",a]
#define kHomeDir NSHomeDirectory()
#define kDocDir  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define kNum2Str(A)  [NSString stringWithFormat:@"%ld",(A)]
#define kNetJsonCode(A) [[(A) objectForKey:@"result"] integerValue];
#define KHudShowInView   [MBProgressHUD showHUDAddedTo:self.view animated:YES];
#define KHudHideInView   [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
#define kHudNetError     [Dialog simpleToast:kNetError];

#endif /* SysMacro_h */
