//
//  LPYNumberPad.m
//  LPYFramework
//
//  Created by admin on 16/1/8.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYNumberPad.h"
#import "LPYNumberButton.h"

#define keyboardH 216.0f
#define keyboardW [UIScreen mainScreen].bounds.size.width

@interface LPYNumberPad()
//  所有数字按钮
@property (nonatomic, copy) NSArray *numberButtons;
// 左边按钮
@property (nonatomic, strong) LPYNumberButton *leftButton;
// delegate
@property (nonatomic, weak) id<LPYNumberPadDelegate> delegate;
// 自动检测文本输入
@property (nonatomic, weak) UIResponder<UITextInput> *textInput;
@end

@implementation LPYNumberPad

+ (instancetype)numberPadWithDelegate:(id<LPYNumberPadDelegate>)delegate {
    return [[self alloc] initWithDelegate:delegate];
}

- (instancetype)initWithDelegate:(id<LPYNumberPadDelegate>)delegate {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.frame = CGRectMake(0.0f, 0.0f, keyboardW, keyboardH);
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight; // 支持旋转
        self.backgroundColor = [UIColor grayColor];
        [self addNotificationsObservers];
        
        self.delegate = delegate;
        
        NSMutableArray *numbersButtons = [NSMutableArray array];
        for (int i = 0; i < 11; i++) {
            LPYNumberButton *numberButton = [self numberButton:i];
            [self addSubview:numberButton];
            [numbersButtons addObject:numberButton];
        }
        self.numberButtons = numbersButtons;
        
        // clearButton
        self.clearButton = [self functionButton];
    }
    return self;
}

#pragma mark - 数字按钮
- (LPYNumberButton *)numberButton:(int)number {
    LPYNumberButton *btn = [LPYNumberButton buttonWithBackgroundColor:[UIColor greenColor] highlightedColor:[UIColor orangeColor]];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [btn setTitle:[NSString stringWithFormat:@"%d", number] forState:UIControlStateNormal];
    return btn;
}

- (LPYNumberButton *)functionButton {
    LPYNumberButton *btn = [LPYNumberButton buttonWithBackgroundColor:[UIColor blackColor] highlightedColor:[UIColor yellowColor]];
    btn.exclusiveTouch = YES;
    return btn;
}

#pragma mark - 通知
- (void)addNotificationsObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)textDidBeginEditing:(NSNotification *)notification {

}

- (void)textDidEndEditing:(NSNotification *)notification {
    
}
@end
