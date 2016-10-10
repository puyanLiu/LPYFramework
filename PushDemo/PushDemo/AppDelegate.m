//
//  AppDelegate.m
//  PushDemo
//
//  Created by admin on 16/9/21.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate () <UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self setRemoteNotificationWithApplication:application didFinishLaunchingWithOptions:launchOptions];
    [self setLocalNotification];
    
    
    // 移除所有本地通知
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    NSLog(@"----%@", [[UIApplication sharedApplication] scheduledLocalNotifications]);
    return YES;
}


#pragma mark - 远程推送
- (void)setRemoteNotificationWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
        #ifdef NSFoundationVersionNumber_iOS_9_x_Max
        
        // iOS 10
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        // 监听通知的接收和点击
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (error) {
                NSLog(@"error: %@", error);
            } else {
                if (granted) {
                    NSLog(@"注册成功");
                    
                    // 获取当前的通知设置，UNNotificationSettings是只读对象
                    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                        NSLog(@"remoteSetting: %@", settings);
                    }];
                    
                } else {
                    NSLog(@"注册失败");
                }
            }
        }];
        
        #endif
    } else {
        if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
            // iOS 8，创建UIUserNotificationSettings，并设置消息的显示类类型
            UIUserNotificationSettings *notiSettings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound) categories:nil];
            [application registerUserNotificationSettings:notiSettings];
        }
        
        NSLog(@"iOS8 推送内容-------%@", launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey]);
    }
    
    // 注册获得deviceToken
    [application registerForRemoteNotifications];
}

// 获得deviceToken
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"iOS10以下收到通知：%@", userInfo);
    
    completionHandler(UIBackgroundFetchResultNewData);
}

#pragma mark - 本地推送
- (void)setLocalNotification {
    // 使用UNUserNotificationCenter管理通知
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    // 监听回调事件
    center.delegate = self;
    // iOS10使用以下方法注册，才能得到授权，注册通知以后，会自动注册deviceToken，Xcode8开启Capability->Push Notification
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error: %@", error);
        }
    }];
    
    // 获取当前的通知设置，UNNotificationSettings是只读对象
    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        NSLog(@"LocalSetting: %@", settings);
    }];
}

#pragma mark - UNUserNotificationCenterDelegate
// iOS10 需要以下两方法
// 在展示通知前进行处理，即有机会在展示通知前再修改通知内容
// APP在前台的时候收到推送执行的回调方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSLog(@"收到通知----%@", notification);
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSString *body = content.body;    // 推送消息体
    NSString *title = content.title;  // 推送消息的标题
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSNumber *badge = content.badge;  // 推送消息的角标
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSDictionary *userInfo = notification.request.content.userInfo;
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        NSLog(@"iOS10 前台收到远程通知:%@", userInfo);
        // 处理通知
        [self handleRemoteNotificationForcegroundWithUserInfo:userInfo];
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    
    // 处理完成后用completionHandler，用于指示在前台显示通知的形式
    completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound);
}

// APP在后台的时候，点击推送消息，进入APP后执行的回调方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    NSLog(@"点击通知----%@", response);
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSString *body = content.body;    // 推送消息体
    NSString *title = content.title;  // 推送消息的标题
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSNumber *badge = content.badge;  // 推送消息的角标
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        NSLog(@"iOS10 收到远程通知:%@", userInfo);
        [self handleRemoteNotificationBackgroundWithUserInfo:userInfo];
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    
    // Warning: UNUserNotificationCenter delegate received call to -userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler: but the completion handler was never called.
    completionHandler();  // 系统要求执行这个方法
}

- (void)handleRemoteNotificationForcegroundWithUserInfo:(NSDictionary *)userInfo {
    // 收到通知
    
}

- (void)handleRemoteNotificationBackgroundWithUserInfo:(NSDictionary *)userInfo {
    // 点击通知
}


@end
