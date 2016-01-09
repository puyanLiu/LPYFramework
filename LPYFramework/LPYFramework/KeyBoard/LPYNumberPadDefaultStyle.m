//
//  LPYNumberPadDefaultStyle.m
//  LPYFramework
//
//  Created by admin on 16/1/8.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYNumberPadDefaultStyle.h"

#define keyboardH 216.0f
#define keyboardW [UIScreen mainScreen].bounds.size.width

@implementation LPYNumberPadDefaultStyle
+ (CGRect)numberPadFrame {
    return CGRectMake(0.0f, 0.0f, keyboardW, keyboardH);
}

+ (CGFloat)separator {
    return [UIScreen mainScreen].scale == 2.0f ? 0.5f : 1.0f;
}

+ (UIColor *)numberPadBackgroundColor {
    return [UIColor redColor];
}

+ (UIFont *)numberButtonFont {
    return [UIFont systemFontOfSize:16.0f];
}

+ (UIColor *)numberButtonBackgroundColor {
    return [UIColor greenColor];
}

+ (UIColor *)numberButtonHighlightedColor {
    return [UIColor yellowColor];
}

+ (UIColor *)numberButtonTextColor {
    return [UIColor redColor];
}

+ (UIFont *)functionButtonFont {
    return [UIFont systemFontOfSize:16.0f];
}

+ (UIColor *)functionButtonBackgroundColor {
    return [UIColor yellowColor];
}

+ (UIColor *)functionButtonHighlightedColor {
    return [UIColor greenColor];
}

+ (UIColor *)functionButtonTextColor {
    return [UIColor redColor];
}

+ (UIImage *)clearFunctionButtonImage {
    return [UIImage imageNamed:@"LPYNumberPad.bundle/Images/clearBtn.png"];
}
@end

