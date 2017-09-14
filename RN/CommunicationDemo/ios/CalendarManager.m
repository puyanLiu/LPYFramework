//
//  CalendarManager.m
//  CalendarDemo
//
//  Created by 刘蒲艳 on 16/9/7.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "CalendarManager.h"
#import "RCTConvert.h"
#import "RCTBridge.h"
#import "RCTEventDispatcher.h"

@implementation CalendarManager

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(setUserInfo:(NSString *)name address:(NSString *)address) {
  NSLog(@"name: %@, address: %@", name, address);
}

RCT_REMAP_METHOD(setUserInfo2, setUserInfo:(NSString *)name address:(NSString *)address phone:(NSString *)phone) {
  NSLog(@"name: %@, address: %@, phone: %@", name, address, phone);
}

RCT_EXPORT_METHOD(setUserName:(NSString *)name brithday:(NSString *)birthday) {
  NSDate *date = [RCTConvert NSDate:birthday];
  NSLog(@"name: %@, birthday: %@", name, date);
}

// 自动类型转换
RCT_EXPORT_METHOD(setUserNameBirthdayAge:(NSString *)name brithday:(NSDate *)birthday age:(nonnull NSNumber *)age) {
  NSLog(@"birthday :%@", [birthday class]);
  NSLog(@"name: %@, birthday: %@, age: %d", name, birthday, [age intValue]);
}

// date 以unix时间戳传递 date1 以ISO-8601字符串形式传递
RCT_EXPORT_METHOD(dateConvert:(nonnull NSNumber *)secondsSinceUnixEpoch ISO8601DateString:(NSString *)ISO8601DateString) {
  NSDate *date = [RCTConvert NSDate:secondsSinceUnixEpoch];
  NSDate *date1 = [RCTConvert NSDate:ISO8601DateString];
  NSLog(@"date: %@, date1: %@", date, date1);
}

// 使用字典存放所有的事件参数
RCT_EXPORT_METHOD(setUser:(NSDictionary *)user) {
  NSString *name = [RCTConvert NSString:user[@"name"]];
  NSDate *birthday = [RCTConvert NSDate:user[@"birthday"]];
  NSLog(@"name: %@, birthday: %@", name, birthday);
}

// 回调函数callback OC->JS
// RCTResponseSenderBlock只接受一个参数——传递给JavaScript回调函数的参数数组
RCT_EXPORT_METHOD(jsGetNames:(RCTResponseSenderBlock)callback) {
  NSArray *array = @[@"zhangsan", @"lisi"];
  callback(@[[NSNull null], array]);
}

// promises
RCT_EXPORT_METHOD(findEventsResolver: (RCTPromiseResolveBlock)resolve
                  rejecte:(RCTPromiseRejectBlock)reject) {
  NSArray *array = @[@"zhangsan", @"lisi"];
  if (array.count > 1) {
    resolve(array);
  } else {
    NSError *error = [NSError errorWithDomain:@"domain" code:-102 userInfo:nil];
    reject(@"-101", @"数组长度必须大于2", error);
  }
}


// 多线程
// 原生模块指定自己想在哪个队列中被执行，如下例子模块需要调用一些必须在主线程中才能使用的API
// methodQueue会被模块里所有方法共享
//- (dispatch_queue_t)methodQueue {
//  return dispatch_get_main_queue();
//}

// 操作需要花费很长时间，原生模块不应被阻塞住，而应当声明一个用于执行操作的独立队列
//- (dispatch_queue_t)methodQueue {
//  return dispatch_queue_create("com.facebook.React.AsyncLocalStorageQueue", DISPATCH_QUEUE_SERIAL);
//}

// 单个方法指定队列
RCT_EXPORT_METHOD(doSomethingFor:(NSString *)param callbackL:(RCTResponseSenderBlock)callback) {
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    // 执行耗时操作
    for(int i = 0; i < 10000; i++) {
      RCTLog(@"%d------%@", i, param);
    }
    
    // 执行回调
    callback(@[[NSNull null], @[@"hello", @"world"]]);
  });
}

// 导出常量
// 原生模块导出常量，在JS端访问。。。用这种方法来传递一些静态数据，可以避免通过bridge进行一次来回交互
// 注意：常量仅仅在初始化的时候导出一次，即使在运行期间改变常量的值，也不会影响到JS环境下所得到的结果
//- (NSDictionary<NSString *,id> *)constantsToExport {
//  return @{@"firstDayofTheWeek" : @"Monday"};
//}

// 枚举常量
// 用NS_ENUM定义的枚举类型必须要先扩展对应的RCTConvert方法才可以作为函数参数传递
// 导出enum值作为常量
- (NSDictionary<NSString *,id> *)constantsToExport {
  return  @{@"firstDayofTheWeek" : @"Monday",
            @"UIStatusBarAnimationNone" : @(UIStatusBarAnimationNone),
            @"UIStatusBarAnimationFade" : @(UIStatusBarAnimationFade),
            @"UIStatusBarAnimationSlide" : @(UIStatusBarAnimationSlide)
            };
}

// 此方法会提示 必须在主线程中执行
RCT_EXPORT_METHOD(updateStatusBarAnimation:(UIStatusBarAnimation)animation completion:(RCTResponseSenderBlock)callback) {
  
  dispatch_async(dispatch_get_main_queue(), ^{
    BOOL statusBarHidden = [UIApplication sharedApplication].statusBarHidden;
    [[UIApplication sharedApplication] setStatusBarHidden:!statusBarHidden withAnimation:animation];
    
    callback(@[[NSNull null], @[@"success"]]);
  });
}

// 给JS发送事件
// 即使没有被JS调用，本地模块也可以给JS发送事件通知，最直接的方式就是使用eventDispatcher:
@synthesize bridge = _bridge;

- (void)calendarEventReminderReceived:(NSNotification *)notification {
  NSString *eventName = notification.userInfo[@"name"];
  // 此方法已过期
  [self.bridge.eventDispatcher sendAppEventWithName:@"EventReminder" body:@{@"name": eventName}];
}


@end
