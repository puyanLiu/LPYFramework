//
//  LPYNumberPadDefaultStyle.h
//  LPYFramework
//
//  Created by admin on 16/1/8.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol LPYNumberPadStyle;

@interface LPYNumberPadDefaultStyle : NSObject <LPYNumberPadStyle>

@end

@protocol LPYNumberPadStyle <NSObject>

+ (CGRect)numberPadFrame;
+ (CGFloat)separator;
+ (UIColor *)numberPadBackgroundColor;

+ (UIFont *)numberButtonFont;
+ (UIColor *)numberButtonBackgroundColor;
+ (UIColor *)numberButtonHighlightedColor;
+ (UIColor *)numberButtonTextColor;

+ (UIFont *)functionButtonFont;
+ (UIColor *)functionButtonBackgroundColor;
+ (UIColor *)functionButtonHighlightedColor;
+ (UIColor *)functionButtonTextColor;
+ (UIImage *)clearFunctionButtonImage;

@end