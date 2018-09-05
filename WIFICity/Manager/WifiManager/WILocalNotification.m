//
//  WILocalNotification.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/9/5.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WILocalNotification.h"

@implementation WILocalNotification

@end



@implementation WILocalNotificationPush

+ (void)pushNotification:(id )noti {
    if (@available(iOS 10.0, *)) {
        if ([noti isKindOfClass:[UNNotificationRequest class]]) {
            UNNotificationRequest *request = (UNNotificationRequest *)noti;
            [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            }];
        }
    } else {
        if ([noti isKindOfClass:[UILocalNotification class]]) {
            UILocalNotification *localNotification = (UILocalNotification *)noti;
             [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        }
    }
}

@end
