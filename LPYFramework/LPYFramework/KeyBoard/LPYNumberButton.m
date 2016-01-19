//
//  LPYNumberButton.m
//  LPYFramework
//
//  Created by admin on 16/1/8.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYNumberButton.h"
#import "UIImage+LPYNumberPad.h"

@implementation LPYNumberButton
+ (instancetype)buttonWithBackgroundColor:(UIColor *)backgroundColor highlightedColor:(UIColor *)highlightedColor {
    return [[self alloc] initWithBackgroundColor:backgroundColor highlightedColor:highlightedColor];
}

- (instancetype)initWithBackgroundColor:(UIColor *)backgroundColor highlightedColor:(UIColor *)highlightedColor {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self setBackgroundImage:[UIImage lpyImageWithColor:backgroundColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage lpyImageWithColor:highlightedColor] forState:UIControlStateHighlighted];
    }
    return self;
}

#pragma mark - UIResponder
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.nextResponder touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    [self.nextResponder touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self.nextResponder touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    [self.nextResponder touchesCancelled:touches withEvent:event];
}

- (void)lpy_touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
}
@end
