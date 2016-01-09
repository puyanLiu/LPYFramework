//
//  LPYNumberButton.h
//  LPYFramework
//
//  Created by admin on 16/1/8.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPYNumberButton : UIButton
+ (instancetype)buttonWithBackgroundColor:(UIColor *)backgroundColor highlightedColor:(UIColor *)highlightedColor;

- (instancetype)initWithBackgroundColor:(UIColor *)backgroundColor highlightedColor:(UIColor *)highlightedColor;

- (void)lpy_touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
@end
