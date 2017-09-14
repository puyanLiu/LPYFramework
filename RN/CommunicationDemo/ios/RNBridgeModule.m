//
//  RNBridgeModule.m
//  CommunicationDemo
//
//  Created by admin on 16/8/26.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "RNBridgeModule.h"
//#import "RCTEventDispatcher.h"

@interface RNBridgeModule ()

@end

@implementation RNBridgeModule

//@synthesize bridge = _bridge;

/*
 实现此宏定义，必须实现，其中括号中的参数可省略（默认为桥接类的名称），也可自定义，主要用来指定在JS中访问这个模块的名称
 #define RCT_EXPORT_MODULE(js_name) \
 RCT_EXTERN void RCTRegisterModule(Class); \
 + (NSString *)moduleName { return @#js_name; } \
 + (void)load { RCTRegisterModule(self); }
 */
RCT_EXPORT_MODULE(RNBridgeModule)

RCT_EXPORT_METHOD(RNBackOC:(NSDictionary *)dictionay) {
  // 返回原生界面
  // [self.navigationController popViewControllerAnimated:YES];
  
  NSLog(@"被点击了");
  dispatch_async(dispatch_get_main_queue(), ^{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RNBackOCNotification" object:dictionay[@"className"]];
  });
}



# pragma mark - RN传参数调用OC原生方法

// 通过callback
RCT_EXPORT_METHOD(RNInvokeOCCallBack:(NSDictionary *)dictionay callback:(RCTResponseSenderBlock)callback) {
  NSLog(@"RN传参数调用OC原生方法，并且传递数据给RN---------接收到RN传递的数据为：%@", dictionay);
  // typedef void (^RCTResponseSenderBlock)(NSArray *response); callback参数需是数组
  NSArray *events = @[@"hello", @"world"];
  callback(@[[NSNull null], events]);
}


// 通过promise
RCT_EXPORT_METHOD(RNInvokeOCPromise:(NSDictionary *)dictionay resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
  NSLog(@"RN传参数调用OC原生方法，并且传递数据给RN---------接收到RN传递的数据为：%@", dictionay);
  NSString *value = [dictionay objectForKey:@"name"];
  if ([value isEqualToString:@"xiaozhang"]) {
    resolve(@"回调成功");()
  } else {
    NSError *error = [NSError errorWithDomain:@"传入的name不符合要求,回调失败啦" code:200 userInfo:nil];
    reject(@"200", @"回调失败", error);
  }
}

- (NSArray<NSString *> *)supportedEvents {
  return @[@"OCInvokeRNEvent"];
}

#pragma mark - 原生调用RN
RCT_EXPORT_METHOD(OCInvokeRN:(NSDictionary *)dictionay) {
  NSLog(@"---%@----%@", self.bridge, dictionay);
  NSString *value = [dictionay objectForKey:@"name"];
  if ([value isEqualToString:@"xiaowang"]) {
//    [self.bridge.eventDispatcher sendAppEventWithName:@"OCInvokeRNEvent" body:@{@"name": [NSString stringWithFormat:@"%@", value], @"errorCode": @(0), @"msg": @"成功"}];
    
    [self sendEventWithName:@"OCInvokeRNEvent" body:@{@"name": [NSString stringWithFormat:@"%@", value], @"errorCode": @(0), @"msg": @"成功"}];
    
  } else {
//    [self.bridge.eventDispatcher sendAppEventWithName:@"OCInvokeRNEvent" body:@{@"name": [NSString stringWithFormat:@"%@", value], @"errorCode": @(100), @"msg": @"输入错误"}];
    
    [self sendEventWithName:@"OCInvokeRNEvent" body:@{@"name": [NSString stringWithFormat:@"%@", value], @"errorCode": @(100), @"msg": @"输入错误"}];
  }
}

#pragma mark - RN界面跳转到原生界面
RCT_EXPORT_METHOD(RNInvokeOCOpenOCVC: (NSString *)className) {
  NSLog(@"--------传递的类名%@", className);
  [[NSNotificationCenter defaultCenter] postNotificationName:@"RNPushOCNotification" object:className];
}

@end
