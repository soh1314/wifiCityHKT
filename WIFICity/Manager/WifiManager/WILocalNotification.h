//
//  WILocalNotification.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/9/5.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>
@interface WILocalNotification : NSObject

@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *badgeNum;

@end

@interface WITimeLocalNotification:WILocalNotification

@property (nonatomic,assign)NSTimeInterval fireDate;

+ (UILocalNotification *)createNotificationWith:(WILocalNotification *)noti;
+ (UNNotificationRequest *)createNotificationRequestWith:(WILocalNotification *)noti;

@end

@interface WIRegionLocalNotification:WILocalNotification


@end

@interface WILocalNotificationPush : NSObject

+ (void)pushNotification:(id)noti;

@end
