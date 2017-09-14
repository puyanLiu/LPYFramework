//
//  RCTConvert+StatusBarAnimation.m
//  CalendarDemo
//
//  Created by 刘蒲艳 on 16/9/10.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "RCTConvert+StatusBarAnimation.h"
#import <UIKit/UIKit.h>

@implementation RCTConvert (StatusBarAnimation)

RCT_ENUM_CONVERTER(UIStatusBarAnimation,
                   (@{
                      @"UIStatusBarAnimationNone" : @(UIStatusBarAnimationNone),
                      @"UIStatusBarAnimationFade" : @(UIStatusBarAnimationFade),
                      @"UIStatusBarAnimationSlide" : @(UIStatusBarAnimationSlide)
                      }), UIStatusBarAnimationNone, integerValue)

@end
