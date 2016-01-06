//
//  UIView+Extension.h
//  QQMProject
//
//  Created by admin on 15/10/19.
//  Copyright © 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
/**
 *  高度
 */
@property (nonatomic,assign) CGFloat height_;

/**
 *  宽度
 */
@property (nonatomic,assign) CGFloat width_;

/**
 *  x
 */
@property (nonatomic,assign) CGFloat x_;

/**
 *  y
 */
@property (nonatomic,assign) CGFloat y_;

@property (nonatomic,assign) CGFloat centerX_;

@property (nonatomic,assign) CGFloat centerY_;

@property (nonatomic,assign) CGSize size_;

/**
 *  判断是否显示在当前窗口
 */
+ (BOOL)isShowOnKeyWindow:(UIView *)view;

// 从xib中加载
+ (instancetype)viewFromXib;

// 获取view的控制器
- (UIViewController *)viewController;
@end
