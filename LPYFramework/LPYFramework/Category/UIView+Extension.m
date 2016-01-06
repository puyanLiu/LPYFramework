//
//  UIView+Extension.m
//  QQMProject
//
//  Created by admin on 15/10/19.
//  Copyright © 2015年 admin. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
- (void)setWidth_:(CGFloat)width_
{
    CGRect frame = self.frame;
    frame.size.width = width_;
    self.frame = frame;
}

- (CGFloat)width_
{
    return self.frame.size.width;
}

- (void)setHeight_:(CGFloat)height_
{
    CGRect frame = self.frame;
    frame.size.height = height_;
    self.frame = frame;
}

- (CGFloat)height_
{
    return self.frame.size.height;
}

- (void)setX_:(CGFloat)x_
{
    CGRect frame = self.frame;
    frame.origin.x = x_;
    self.frame = frame;
}

- (CGFloat)x_
{
    return self.frame.origin.x;
}

- (void)setY_:(CGFloat)y_
{
    CGRect frame = self.frame;
    frame.origin.y = y_;
    self.frame = frame;
}

- (CGFloat)y_
{
    return self.frame.origin.y;
}

- (void)setCenterX_:(CGFloat)centerX_
{
    CGPoint center = self.center;
    center.x = centerX_;
    self.center = center;
}

-(CGFloat)centerX_
{
    return self.center.x;
}

- (void)setCenterY_:(CGFloat)centerY_
{
    CGPoint center = self.center;
    center.y = centerY_;
    self.center = center;
}

- (CGFloat)centerY_
{
    return self.center.y;
}

- (void)setSize_:(CGSize)size_
{
    CGRect frame = self.frame;
    frame.size = size_;
    self.frame = frame;
}

- (CGSize)size_
{
    return self.frame.size;
}

+ (BOOL)isShowOnKeyWindow:(UIView *)view
{
    // 将当前View的坐标系转换为窗口坐标系
    // 第二个参数如果写nil，表示的也是UIWindow
    //        CGPoint windowP = [subView convertPoint:subView.frame.origin toView:[UIApplication sharedApplication].keyWindow];
    // 将控件在父控件的坐标系转换为在主窗口的坐标系
    
    // 判断两个矩形是否相交
    //        CGRectIntersectsRect(<#CGRect rect1#>, <#CGRect rect2#>)
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    CGRect windowRect = window.bounds;
    CGRect newRect = [view.superview convertRect:view.frame toView:window];
    return view.window == window && !view.hidden && view.alpha > 0.01 && CGRectIntersectsRect(windowRect, newRect);
}

+ (instancetype)viewFromXib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (UIViewController *)viewController {
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
