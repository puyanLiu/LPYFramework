//
//  LPYSubscriptionServiceCenter.m
//  LPYFramework
//
//  Created by admin on 16/1/18.
//  Copyright © 2016年 liupuyan. All rights reserved.
// 订阅服务中心

#import "LPYSubscriptionServiceCenter.h"

static NSMutableDictionary *_subscriptionDictionary = nil;

@implementation LPYSubscriptionServiceCenter

+ (void)initialize {
    if (self == [LPYSubscriptionServiceCenter class]) {
        _subscriptionDictionary = [NSMutableDictionary dictionary];
    }
}

+ (void)createSubscriptionNumber:(NSString *)subscriptionNumber {
    NSParameterAssert(subscriptionNumber);
    
    NSHashTable *hashTable = [self existSubscriptionNumber:subscriptionNumber];
    if (hashTable == nil) {
        hashTable = [NSHashTable weakObjectsHashTable];
        [_subscriptionDictionary setObject:hashTable forKey:subscriptionNumber];
    }
}

+ (void)removeSubscriptionNumber:(NSString *)subscriptionNumber {
    NSParameterAssert(subscriptionNumber);
    
    NSHashTable *hashTable = [self existSubscriptionNumber:subscriptionNumber];
    if (hashTable) {
        [_subscriptionDictionary removeObjectForKey:subscriptionNumber];
    }
}

+ (void)addCustomer:(id<LPYSubscriptionServiceCenterProtocol>)customer withSubscriptionNumber:(NSString *)subscriptionNumber {
    NSParameterAssert(subscriptionNumber);
    NSParameterAssert(customer);
    
    NSHashTable *hashTable = [self existSubscriptionNumber:subscriptionNumber];
    // 如果不存在，对nil值执行任何操作将没有反应
    [hashTable addObject:customer];
}

+ (void)removeCustomer:(id<LPYSubscriptionServiceCenterProtocol>)customer withSubscriptionNumber:(NSString *)subscriptionNumber {
    NSParameterAssert(subscriptionNumber);
    
    NSHashTable *hashTable = [self existSubscriptionNumber:subscriptionNumber];
    [hashTable removeObject:customer];
}

+ (void)sendMessage:(id)message toSubscriptionNumber:(NSString *)subscriptionNumber {
    NSParameterAssert(subscriptionNumber);
    
    NSHashTable *hashTable = [self existSubscriptionNumber:subscriptionNumber];
    if (hashTable) {
        NSEnumerator *enumerator = [hashTable objectEnumerator];
        id<LPYSubscriptionServiceCenterProtocol> object = nil;
        while (object = [enumerator nextObject]) {
            if ([object respondsToSelector:@selector(subscriptionMessage:subscriptionNumber:)]) {
                [object subscriptionMessage:message subscriptionNumber:subscriptionNumber];
            }
        }
    }
}

#pragma mark - 私有方法
// 验证订阅号是否存在
+ (NSHashTable *)existSubscriptionNumber:(NSString *)subscriptionNumber {
    return [_subscriptionDictionary objectForKey:subscriptionNumber];
}
@end
