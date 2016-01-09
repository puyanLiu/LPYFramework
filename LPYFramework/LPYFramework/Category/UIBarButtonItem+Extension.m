//
//  UIBarButtonItem+Extension.m
//  QQMProject
//
//  Created by 刘蒲艳 on 15/10/19.
//  Copyright © 2015年 admin. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

- (instancetype)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage target:(id)target action:(SEL)action
{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setBackgroundImage:image forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    [leftBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [leftBtn sizeToFit];
    return [self initWithCustomView:leftBtn];
}

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image highlightedImage:(UIImage *)highlightedImage target:(id)target action:(SEL)action
{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:image forState:UIControlStateNormal];
    [leftBtn setImage:highlightedImage forState:UIControlStateHighlighted];
    
    [leftBtn setTitle:title forState:UIControlStateNormal];
    
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [leftBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    // 设置按钮距离左边的距离
    leftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    
    [leftBtn sizeToFit];
    return [self initWithCustomView:leftBtn];
    
}

- (instancetype)initWithTitle:(NSString *)title selectedTitle:(NSString *)selectedTitle target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:selectedTitle forState:UIControlStateSelected];
    btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [btn sizeToFit];
    return [self initWithCustomView:btn];
}
@end
