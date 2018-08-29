//
//  WIFIPusher.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/20.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WIFIPusher.h"
#import "NSString+Additions.h"
#import "WebViewController.h"

static NSInteger otTime;

@implementation WIFIPusher

+ (void)requestAuthor
{
 
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 设置通知的类型可以为弹窗提示,声音提示,应用图标数字提示
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
        // 授权通知
        [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
    }
}

+ (void)sendWIFINoti {
    NSString *otNumStr = [[NSUserDefaults standardUserDefaults]objectForKey:LASTHKTWIFIORGIDOTTIMEKEY];
    NSInteger otNum ;
    if (otNumStr) {
        otNum = [otNumStr integerValue];
    } else {
        otNum = 30;
    }
    NSInteger nowtime = [[NSString unixTimeStamp]integerValue];
    if (nowtime - otTime < 800) {
        otTime = nowtime;
        return;
    }
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    // 2.设置通知的必选参数
    // 设置通知显示的内容
    localNotification.alertBody = @"华宽通WiFi提醒您的WiFi时间即将过期,请重新登录app认证";
    // 设置通知的发送时间,单位秒
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:otNum*59];
    //解锁滑动时的事件
    localNotification.alertAction = @"您的WiFi时间即将过期,请重新登录app认证";
    //收到通知时App icon的角标
    localNotification.applicationIconBadgeNumber = 1;
    //推送是带的声音提醒，设置默认的字段为UILocalNotificationDefaultSoundName
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    // 3.发送通知(🐽 : 根据项目需要使用)
    // 方式一: 根据通知的发送时间(fireDate)发送通知
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
}

@end
