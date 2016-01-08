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
@end
