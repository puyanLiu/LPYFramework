//
//  LPYNumberPad.h
//  LPYFramework
//
//  Created by admin on 16/1/8.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LPYNumberPadDelegate;

@interface LPYNumberPad : UIView
+ (instancetype)numberPadWithDelegate:(id<LPYNumberPadDelegate>)delegate;

// 左边按钮
@property (nonatomic, strong) UIButton *leftFunctionButton;
// 右边按钮
@property (nonatomic, strong) UIButton *clearButton;
@end

@protocol LPYNumberPadDelegate <NSObject>

@optional
- (void)numberPad:(LPYNumberPad *)numberPad functionButtonAction:(UIButton *)functionButton textInput:(UIResponder<UITextInput> *)textInput;
@end

