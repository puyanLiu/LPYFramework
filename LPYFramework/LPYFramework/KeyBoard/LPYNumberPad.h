//
//  LPYNumberPad.h
//  LPYFramework
//
//  Created by admin on 16/1/8.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPYNumberPadStyle.h"

@protocol LPYNumberPadDelegate;

@interface LPYNumberPad : UIView

// 左边按钮
@property (nonatomic, strong, readonly) UIButton *leftFunctionButton;
// 右边按钮
@property (nonatomic, strong) UIButton *clearButton;
// 样式
@property (nonatomic, strong, readonly) Class<LPYNumberPadStyle> styleClass;

+ (instancetype)numberPadWithDelegate:(id<LPYNumberPadDelegate>)delegate;

+ (instancetype)numberPadWithDelegate:(id<LPYNumberPadDelegate>)delegate numberPadStyleClass:(Class)styleClass;
@end

@protocol LPYNumberPadDelegate <NSObject>

@optional
// 若左边按钮需要执行操作时，需要实现此方法
- (void)numberPad:(LPYNumberPad *)numberPad functionButtonAction:(UIButton *)functionButton textInput:(UIResponder<UITextInput> *)textInput;
@end

