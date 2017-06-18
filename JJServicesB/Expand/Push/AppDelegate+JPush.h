//
//  AppDelegate+JPush.h
//  ZHCustomer
//
//  Created by  tianlei on 2017/2/6.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "AppDelegate.h"
#import "JPUSHService.h"


@interface AppDelegate (JPush)<JPUSHRegisterDelegate>


- (void)jpushInitWithLaunchOption:(NSDictionary *)launchOptions;

- (void)jpushRegisterDeviceToken:(NSData *)deviceToken;

//ios10 - 7 收到远程推送
- (void)jpushDidReceiveRemoteNotification:(NSDictionary *)userInfo;

//ios10 - 7 收到本地推送
- (void)jpushDidReceiveLocalNotification:(UILocalNotification *)notification;

@end
