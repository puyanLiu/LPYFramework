//
//  LPYSubscriptionServiceCenter.h
//  LPYFramework
//
//  Created by admin on 16/1/18.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPYSubscriptionServiceCenterProtocol.h"

@interface LPYSubscriptionServiceCenter : NSObject

#pragma mark - 维护订阅信息
// 创建订阅号
+ (void)createSubscriptionNumber:(NSString *)subscriptionNumber;

// 移除订阅号
+ (void)removeSubscriptionNumber:(NSString *)subscriptionNumber;

#pragma mark - 维护客户信息
// 添加客户到具体的订阅号中
+ (void)addCustomer:(id<LPYSubscriptionServiceCenterProtocol>)customer withSubscriptionNumber:(NSString *)subscriptionNumber;

// 从具体的订阅号中移除客户
+ (void)removeCustomer:(id<LPYSubscriptionServiceCenterProtocol>)customer withSubscriptionNumber:(NSString *)subscriptionNumber;

#pragma mark - 发送消息
// 发送消息到具体的订阅号当中
+ (void)sendMessage:(id)message toSubscriptionNumber:(NSString *)subscriptionNumber;
@end
