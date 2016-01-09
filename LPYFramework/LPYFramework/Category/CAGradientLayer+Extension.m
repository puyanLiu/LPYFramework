//
//  CAGradientLayer+Extension.m
//  QQMProject
//
//  Created by 刘蒲艳 on 15/10/28.
//  Copyright © 2015年 admin. All rights reserved.
//

#import "CAGradientLayer+Extension.h"

@implementation CAGradientLayer (Extension)

// 设置橙色渐变色
+ (instancetype)setOrangeGradient
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    UIColor *startColor = [UIColor orangeColor];
    UIColor *endColor = [UIColor orangeColor];
    gradientLayer.colors = @[(id)startColor.CGColor, (id)endColor.CGColor];
    return gradientLayer;
}
@end
