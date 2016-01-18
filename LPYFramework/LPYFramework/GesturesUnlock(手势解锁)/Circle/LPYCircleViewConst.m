//
//  LPYCircleViewConst.m
//  LPYFramework
//
//  Created by admin on 16/1/18.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYCircleViewConst.h"

@implementation LPYCircleViewConst
// 偏好设置：存字符串（手势密码）
+ (void)saveGesture:(NSString *)gesture key:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setObject:gesture forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// 偏好设置：取字符串手势密码
+ (NSString *)getGestureWithKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}
@end
