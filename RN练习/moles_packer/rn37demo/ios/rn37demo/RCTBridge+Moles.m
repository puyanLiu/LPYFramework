//
//  RCTBridge+Moles.m
//  rn37demo
//
//  Created by liupuyan on 16/12/23.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "RCTBridge+Moles.h"
#import <objc/runtime.h>
#import "RCTBridge+Private.h"

static const void *RCTBridgeSecondaryURLKey = &RCTBridgeSecondaryURLKey;

@implementation RCTBridge (Moles)

- (NSURL *)secondaryBundleURL {
  
    /**
     objc_getAssociatedObject 相当于iOS内部的get方法
     用于获取关联对象
     
     @param self 关联对象
     @param RCTBridgeSecondaryURLKey 我们需要定义一个常量void类型的key
     @return <#return value description#>
     */
    id value = objc_getAssociatedObject(self, RCTBridgeSecondaryURLKey);
    return value;
}

- (void)setSecondaryBundleURL:(NSURL *)secondaryBundleURL {
  
    /**
     objc_setAssociatedObject 相当于iOS的属性的set方法
     用于给对象添加关联对象，传入 nil 则可以移除已有的关联对象
     
     @param self 被关联的对象
     @param RCTBridgeSecondaryURLKey char类型的key
     @param secondaryBundleURL 要被赋值的值
     @param OBJC_ASSOCIATION_RETAIN_NONATOMIC 关联策略
     */
    objc_setAssociatedObject(self, RCTBridgeSecondaryURLKey, secondaryBundleURL, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)loadSecondary {
    NSURL *secondaryURL = self.secondaryBundleURL;
    if (!secondaryURL) {
      return;
    }
    // 创建线程 dispatch_queue_create(线程标示，队列类型) 此处是并发队列
    dispatch_queue_t bridgeQueue = dispatch_queue_create("moles.bussiness.RCTBridgeQueue", DISPATCH_QUEUE_CONCURRENT);
    // dispatch_group_create 创建调度任务组
    dispatch_group_t initModulesAndLoadSource = dispatch_group_create();
    // 指明一个任务执行块进入这个组 类似内存管理，每个enter都必须有相对应的leave，否则你的dispatch_group永远不会结束，在你要去请求一个web service的时候,先enter dispatch group,然后在返回的completion block中 leave
    dispatch_group_enter(initModulesAndLoadSource);
    __weak RCTBatchedBridge *batchedBridge = (RCTBatchedBridge *)[self batchedBridge];
    __block NSData *sourceCode;
    // 加载JS代码
    [RCTJavaScriptLoader loadBundleAtURL:secondaryURL onProgress:^(RCTLoadingProgress *progressData) {
      
    } onComplete:^(NSError *error, NSData *source, int64_t sourceLength) {
        sourceCode = source;
        // 执行块执行完毕，移除出组
        dispatch_group_leave(initModulesAndLoadSource);
    }];
    // dispatch group完成方式 不会阻塞当前线程，马上返回
    dispatch_group_notify(initModulesAndLoadSource, bridgeQueue, ^{
      
        RCTBatchedBridge *strongBridge = batchedBridge;
        if (sourceCode) {
            while(strongBridge.isLoading) {
                // 主线程等待，但让出主线程时间片，但让出主线程时间片，有事件到达就返回，比如点击UI等
                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            }
          
          [strongBridge enqueueApplicationScript:sourceCode url:secondaryURL onComplete:^(NSError *error) {
              NSLog(@"%@",error);
              NSLog(@"%@", [[NSString alloc] initWithData:sourceCode encoding:NSUTF8StringEncoding]);
          }];
        }
    
    });
}

@end
