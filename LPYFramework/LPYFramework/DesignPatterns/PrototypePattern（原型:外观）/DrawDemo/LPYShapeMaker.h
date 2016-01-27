//
//  LPYShapeMaker.h
//  LPYFramework
//
//  Created by admin on 16/1/26.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPYShapeMaker : NSObject

/**
 *  绘制圆
 *
 *  @param paras 参数
 */
+ (void)drawCircleWithParas:(NSDictionary *)paras;

/**
 *  绘制圆+矩形
 *
 *  @param paras 参数
 */
+ (void)draCircleAndRectangle:(NSDictionary *)paras;
@end
