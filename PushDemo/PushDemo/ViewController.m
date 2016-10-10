//
//  ViewController.m
//  PushDemo
//
//  Created by admin on 16/9/21.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)btn_SetLocalNotificationClick {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
        [self registerNotification:5];
    } else {
        [self registerLocalNotificationInOldWay:5];
    }
}

//使用 UNNotification 本地通知
- (void)registerNotification:(NSInteger )alerTime{
    // 使用 UNUserNotificationCenter 来管理通知
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    
    //需创建一个包含待通知内容的 UNMutableNotificationContent 对象，注意不是 UNNotificationContent ,此对象为不可变对象。
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
//    content.title = [NSString localizedUserNotificationStringForKey:@"Hello!" arguments:nil];
//    content.body = [NSString localizedUserNotificationStringForKey:@"Hello_message_body" arguments:nil];
    
    content.title = @"我是标题，哈哈哈";
    content.subtitle = @"我是子标题，啦啦啦";
    content.body = @"我是内容，嘻嘻嘻";
    content.badge = @10;
    // 设置声音
    content.sound = [UNNotificationSound defaultSound];
    
    /*
     UNNotificationAttachment（附件通知）是指可以包含音频，图像或视频内容，并且可以将其内容显示出来的通知。使用本地通知时，可以在通知创建时，将附件加入即可。对于远程通知，则必须实现使用UNNotificationServiceExtension类通知服务扩展。
     */
    /*
     附件options属性
     1、UNNotificationAttachmentOptionsTypeHintKey
     此键的值是一个包含描述文件的类型统一类型标识符（UTI）一个NSString。如果不提供该键，附件的文件扩展名来确定其类型，常用的类型标识符有
     kUTTypeImage,kUTTypeJPEG2000,kUTTypeTIFF,kUTTypePICT,kUTTypeGIF ,kUTTypePNG,kUTTypeQuickTimeImage等
     
     2、UNNotificationAttachmentOptionsThumbnailHiddenKey
     是一个BOOL值，为YES时候显示，为NO缩略图将隐藏，默认为YES
     
     3、UNNotificationAttachmentOptionsThumbnailClippingRectKey
     剪贴矩形的缩略图。这个密钥的值是包含一个归一化的CGRect – 也就是说，一个单元的矩形，其值是在以1.0〜 0.0 ，表示要显示的原始图像的所述部分的字典。例如，指定的（0.25 ， 0.25）的原点和大小（0.5 ，0.5 ）定义了剪辑矩形，只显示图像的中心部分。使用CGRectCreateDictionaryRepresentation函数来创建字典的矩形。
     
     4、UNNotificationAttachmentOptionsThumbnailTimeKey
     一般影片附件会用到，指的是用影片中的某一秒来做这个缩略图
     
     
     */
    // 设置通知附件
    NSError *error = nil;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"openRedBg" ofType:@"png"];
//    NSDictionary *options = @{UNNotificationAttachmentOptionsTypeHintKey: (__bridge id _Nullable)(kUTTypeImage)};
    //    NSDictionary *options = @{UNNotificationAttachmentOptionsThumbnailHiddenKey: @(YES)};
    //    NSDictionary *options = @{UNNotificationAttachmentOptionsThumbnailTimeKey: @10};
    NSDictionary *options = @{UNNotificationAttachmentOptionsThumbnailClippingRectKey: (__bridge id _Nullable)((CGRectCreateDictionaryRepresentation(CGRectMake(0, 0, 0.25 ,0.25))))};
    UNNotificationAttachment *att = [UNNotificationAttachment attachmentWithIdentifier:@"att1" URL:[NSURL fileURLWithPath:path] options:options error:&error];
    
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"haha" ofType:@"png"];
    UNNotificationAttachment *att2 = [UNNotificationAttachment attachmentWithIdentifier:@"att2" URL:[NSURL fileURLWithPath:path2] options:nil error:&error];
    if (error) {
        NSLog(@"attachment error: %@", error);
    } else {
        content.attachments = @[att, att2];
        // app通知下来预览时展示的图
        content.launchImageName = @"openRedBg.png";
    }
    
    // 在 alertTime 后推送本地推送
    /*
     1.UNPushNotificationTrigger （远程通知） 远程推送的通知类型
     2.UNTimeIntervalNotificationTrigger （本地通知） 一定时间之后，重复或者不重复推送通知。我们可以设置timeInterval（时间间隔）和repeats（是否重复）。repeats这个属性，如果需要为重复执行的，则TimeInterval必须大于60s,否则会报* Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'time interval must be at least 60 if repeating'的错误!**
     3.UNCalendarNotificationTrigger（本地通知） 一定日期之后，重复或者不重复推送通知 例如，你每天8点推送一个通知，只要dateComponents为8，如果你想每天8点都推送这个通知，只要repeats为YES就可以了。
     4.UNLocationNotificationTrigger （本地通知）地理位置的一种通知，
     当用户进入或离开一个地理区域来通知。在CLRegion标识符必须是唯一的。因为如果相同的标识符来标识不同区域的UNNotificationRequests，会导致不确定的行为
     */
    // 触发模式
    
    UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger
                                                  triggerWithTimeInterval:alerTime repeats:NO];
    
    UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:@"FiveSecond"
                                                                          content:content trigger:trigger];
    
    //添加推送成功后的处理！
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"本地通知" message:@"成功添加推送" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:cancelAction];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    }];
}

- (void)registerLocalNotificationInOldWay:(NSInteger)alertTime {
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    // 设置触发通知的时间
    NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:alertTime];
    NSLog(@"fireDate=%@",fireDate);
    
    notification.fireDate = fireDate;
    // 时区
    notification.timeZone = [NSTimeZone defaultTimeZone];
    // 设置重复的间隔
//    notification.repeatInterval = kCFCalendarUnitSecond;
    notification.repeatInterval = 0;
    
    // 通知内容
    notification.alertBody =  @"该起床了...";
    notification.applicationIconBadgeNumber = 1;
    // 通知被触发时播放的声音
    notification.soundName = UILocalNotificationDefaultSoundName;
    // 通知参数
    NSDictionary *userDict = [NSDictionary dictionaryWithObject:@"开始学习iOS开发了" forKey:@"key"];
    notification.userInfo = userDict;
    
    // ios8后，需要添加这个注册，才能得到授权
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        // 通知重复提示的单位，可以是天、周、月
        notification.repeatInterval = NSCalendarUnitDay;
    } 
    
    // 执行通知注册
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
