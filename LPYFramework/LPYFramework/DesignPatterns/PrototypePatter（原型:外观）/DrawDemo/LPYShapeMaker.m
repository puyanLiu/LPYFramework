//
//  LPYShapeMaker.m
//  LPYFramework
//
//  Created by admin on 16/1/26.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYShapeMaker.h"
#import "LPYCircle.h"
#import "LPYRectangle.h"

@implementation LPYShapeMaker
/**
 *  绘制圆
 *
 *  @param paras 参数
 */
+ (void)drawCircleWithParas:(NSDictionary *)paras {
    // 绘制圆
    LPYCircle *circle = [LPYCircle new];
    circle.radius = 10.0f; // paras里边取
    [circle draw];
}

/**
 *  绘制圆+矩形
 *
 *  @param paras 参数
 */
+ (void)draCircleAndRectangle:(NSDictionary *)paras {
    // 绘制圆
    LPYCircle *circle = [LPYCircle new];
    circle.radius = 10.0f; // paras里边取
    [circle draw];
    
    LPYRectangle *rectangle = [LPYRectangle new];
    rectangle.width = 10.f;
    rectangle.height = 10.f;
    [rectangle draw];
}
@end
