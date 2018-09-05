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
#import <UserNotifications/UserNotifications.h>

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

+ (void)sendWifiExpiredPush:(NSString *)wifiMac {
    if (!wifiMac) {
        return;
    }
    NSInteger expireTimestamp = [[[NSUserDefaults standardUserDefaults]objectForKey:wifiMac]integerValue];
    NSInteger nowTimestamp = [[NSString unixTimeStamp]integerValue];
    if (expireTimestamp > nowTimestamp) {
        return;
    }
    NSString *otNumStr = [[NSUserDefaults standardUserDefaults]objectForKey:LastWiFiOrgID_OutTime_Key];
    NSInteger otNum ;
    if (otNumStr) {
        otNum = [otNumStr integerValue];
    } else {
        otNum = 30;
    }
    NSInteger nowtime = [[NSString unixTimeStamp]integerValue];
    if (nowtime - otTime < 300) {
        otTime = nowtime;
        return;
    }
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 10.0) {
        [self avalable10SendExpireValidatePush:otNum];
    } else {
        [self availabel8SendExpireValidatePush:otNum];
    }
    
}

+ (void)availabel8SendExpireValidatePush:(NSInteger)outTimeNumber {
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    // 2.设置通知的必选参数
    // 设置通知显示的内容
    localNotification.alertBody = @"华宽通WiFi提醒您的WiFi时间即将过期,请重新登录app认证";
    // 设置通知的发送时间,单位秒
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:outTimeNumber*59];
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

+ (void)avalable10SendExpireValidatePush:(NSInteger)outTimeNumber {
    if (@available(iOS 10.0, *)) {
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = @"华宽通WiFi";
        content.body = @"华宽通WiFi提醒您的WiFi时间即将过期,请重新登录app认证";
        content.badge = @1;
        NSError *error = nil;
            NSString *path = [[NSBundle mainBundle] pathForResource:@"recruitment_default@2x" ofType:@"png"];
        // 2.设置通知附件内容
        UNNotificationAttachment *att = [UNNotificationAttachment attachmentWithIdentifier:@"att1" URL:[NSURL fileURLWithPath:path] options:nil error:&error];
        if (error) {
            NSLog(@"attachment error %@", error);
        }
//        content.attachments = @[att];
        content.launchImageName = @"default_img";
        // 2.设置声音
        UNNotificationSound *sound = [UNNotificationSound defaultSound];
        content.sound = sound;
        
        // 3.触发模式
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:outTimeNumber*59 repeats:NO];
        
        // 4.设置UNNotificationRequest
        NSString *requestIdentifer = @"WifiExpireRequest";
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifer content:content trigger:trigger];
        
        //5.把通知加到UNUserNotificationCenter, 到指定触发点会被触发
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        }];
    }
    
}

@end
