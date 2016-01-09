//
//  UIBarButtonItem+Extension.h
//  QQMProject
//
//  Created by 刘蒲艳 on 15/10/19.
//  Copyright © 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
- (instancetype)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage target:(id)target action:(SEL)action;

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image highlightedImage:(UIImage *)highlightedImage target:(id)target action:(SEL)action;

- (instancetype)initWithTitle:(NSString *)title selectedTitle:(NSString *)selectedTitle target:(id)target action:(SEL)action;
@end
