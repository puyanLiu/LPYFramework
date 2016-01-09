//
//  LPYNumberPad.m
//  LPYFramework
//
//  Created by admin on 16/1/8.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYNumberPad.h"
#import "LPYNumberButton.h"
#import "LPYNumberPadDefaultStyle.h"

#define keyboardH 216.0f
#define keyboardW [UIScreen mainScreen].bounds.size.width

@interface LPYNumberPad() <UIInputViewAudioFeedback>
{
    BOOL _clearButtonLongPressGesture;
    
    struct {
        unsigned int textInputSupportsShouldChangeTextInRange:1;
        unsigned int delegateSupportsTextFieldShouldChangeCharactersInRange:1;
        unsigned int delegateSupportsTextViewShouldChangeTextInRange:1;
    } _delegateFlags;
}

// 所有数字按钮
@property (nonatomic, copy) NSArray *numberButtons;
// 左边按钮
@property (nonatomic, strong) LPYNumberButton *leftButton;
// delegate
@property (nonatomic, weak) id<LPYNumberPadDelegate> delegate;
// 自动检测文本输入
@property (nonatomic, weak) UIResponder<UITextInput> *textInput;
// 键盘样式
@property (nonatomic, strong) Class<LPYNumberPadStyle> styleClass;
// 记录上一次触摸
@property (nonatomic, strong) UITouch *lastTouch;
@end

@implementation LPYNumberPad

+ (instancetype)numberPadWithDelegate:(id<LPYNumberPadDelegate>)delegate {
    return [self numberPadWithDelegate:delegate numberPadStyleClass:nil];
}

+ (instancetype)numberPadWithDelegate:(id<LPYNumberPadDelegate>)delegate numberPadStyleClass:(Class)styleClass {
    return [[self alloc] initWithDelegate:delegate numberPadStyleClass:styleClass];
}

- (instancetype)initWithDelegate:(id<LPYNumberPadDelegate>)delegate numberPadStyleClass:(Class)styleClass {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.styleClass = styleClass;
        self.frame = [self.styleClass numberPadFrame];
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight; // 支持旋转
        self.backgroundColor = [self.styleClass numberPadBackgroundColor];
        [self addNotificationsObservers];
        
        self.delegate = delegate;
        
        NSMutableArray *numbersButtons = [NSMutableArray array];
        for (int i = 0; i < 11; i++) {
            LPYNumberButton *numberButton = [self numberButton:i];
            [self addSubview:numberButton];
            [numbersButtons addObject:numberButton];
        }
        self.numberButtons = numbersButtons;
        
        // leftButton
        self.leftButton = [self functionButton];
        self.leftButton.titleLabel.font = [self.styleClass functionButtonFont];
        [self.leftButton setTitleColor:[self.styleClass functionButtonTextColor] forState:UIControlStateNormal];
        [self.leftButton addTarget:self action:@selector(btn_LeftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        self.leftButton.userInteractionEnabled = NO;
        [self addSubview:self.leftButton];
        
        // clearButton
        self.clearButton = [self functionButton];
        [self.clearButton setImage:[self.styleClass clearFunctionButtonImage] forState:UIControlStateNormal];
        [self.clearButton addTarget:self action:@selector(btn_ClearClick) forControlEvents:UIControlEventTouchUpInside];
        
        UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognizerAction:)];
        longPressGestureRecognizer.cancelsTouchesInView = NO;
        [self.clearButton addGestureRecognizer:longPressGestureRecognizer];
        [self addSubview:self.clearButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    int rows = 4;
    int sections = 3;
    CGFloat sep = [self.styleClass separator];
    CGFloat left = 0.0f;
    CGFloat top = 0.0f;
#if defined(__LP64__) && __LP64__
    CGFloat buttonHeight = trunc((CGRectGetHeight(self.bounds) - sep * (rows - 1)) / rows) + sep;
#else
    CGFloat buttonHeight = truncf((CGRectGetHeight(self.bounds) - sep * (rows - 1)) / rows) + sep;
#endif
    CGSize buttonSize = CGSizeMake((CGRectGetWidth(self.bounds) - sep * (sections - 1)) / sections, buttonHeight);
    
    // 1-9
    for (int i = 1; i < self.numberButtons.count - 1; i++) {
        LPYNumberButton *numberButton = self.numberButtons[i];
        numberButton.frame = CGRectMake(left, top, buttonSize.width, buttonSize.height);
        
        if (i % sections == 0) {
            left = 0.0f;
            top += buttonSize.height + sep;
        } else {
            left += buttonSize.width + sep;
        }
    }
    
    // leftButton
    left = 0.0f;
    self.leftButton.frame = CGRectMake(left, top, buttonSize.width, buttonSize.height);
    
    // 0
    left += buttonSize.width + sep;
    UIButton *zeroButton = [self.numberButtons firstObject];
    zeroButton.frame = CGRectMake(left, top, buttonSize.width, buttonSize.height);
    
    // clearButton
    left += buttonSize.width + sep;
    self.clearButton.frame = CGRectMake(left, top, buttonSize.width, buttonSize.height);
}

#pragma mark leftButton
- (void)btn_LeftButtonClick:(id)sender {
    if (!self.textInput) {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(numberPad:functionButtonAction:textInput:)]) {
        [self.delegate numberPad:self functionButtonAction:sender textInput:self.textInput];
    }
}

#pragma mark - UIInputViewAudioFeedback
- (BOOL)enableInputClicksWhenVisible {
    return YES;
}

#pragma mark - clearButton
- (void)longPressGestureRecognizerAction:(UILongPressGestureRecognizer *)longPress {
    if (longPress.state == UIGestureRecognizerStateBegan) {
        _clearButtonLongPressGesture = YES;
        [self clearButtonActionLongPress];
    } else if (longPress.state == UIGestureRecognizerStateEnded) {
        _clearButtonLongPressGesture = NO;
    }
}

- (void)clearButtonActionLongPress {
    if (_clearButtonLongPressGesture) {
        if ([self.textInput hasText]) {
            [[UIDevice currentDevice] playInputClick];
            
            [self btn_ClearClick];
            // delay like in iOS keyboard
            [self performSelector:@selector(clearButtonActionLongPress) withObject:nil afterDelay:0.1f];
        } else {
            _clearButtonLongPressGesture = NO;
        }
    }
}

- (void)btn_ClearClick {
    if (!self.textInput) {
        return;
    }
    
    if (_delegateFlags.textInputSupportsShouldChangeTextInRange) {
        UITextRange *textRange = self.textInput.selectedTextRange;
        
        if ([textRange.start isEqual:textRange.end]) {
            UITextPosition *newStart = [self.textInput positionFromPosition:textRange.start inDirection:UITextLayoutDirectionLeft offset:1];
            textRange = [self.textInput textRangeFromPosition:newStart toPosition:textRange.end];
        }
        
        if ([self.textInput shouldChangeTextInRange:textRange replacementText:@""]) {
            [self.textInput deleteBackward];
        }
    } else if (_delegateFlags.delegateSupportsTextFieldShouldChangeCharactersInRange) {
        NSRange selectedRange = [[self class] selectedRange:self.textInput];
        if (selectedRange.length == 0 && selectedRange.location > 0) {
            selectedRange.location--;
            selectedRange.length = 1;
        }
        
        UITextField *textField = (UITextField *)self.textInput;
        if ([textField.delegate textField:textField shouldChangeCharactersInRange:selectedRange replacementString:@""]) {
            [self.textInput deleteBackward];
        }
    } else if (_delegateFlags.delegateSupportsTextViewShouldChangeTextInRange) {
        NSRange selectedRange = [[self class] selectedRange:self.textInput];
        if (selectedRange.length == 0 && selectedRange.location > 0) {
            selectedRange.location--;
            selectedRange.length = 2;
        }
        
        UITextView *textView = (UITextView *)self.textInput;
        if ([textView.delegate textView:textView shouldChangeTextInRange:selectedRange replacementText:@""]) {
            [self.textInput deleteBackward];
        }
    } else {
        [self.textInput deleteBackward];
    }
}

#pragma mark - UIResponder 
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[UIDevice currentDevice] playInputClick];
    
    if (self.lastTouch) {
        [self performLastTouchAction];
    }
    
    // 禁止多点触碰
    self.lastTouch = [touches anyObject];

    CGPoint location = [self.lastTouch locationInView:self];
    for (LPYNumberButton *btn in self.numberButtons) {
        if (CGRectContainsPoint(btn.frame, location)) {
            btn.highlighted = YES;
        } else {
            btn.highlighted = NO;
            [btn lpy_touchesCancelled:touches withEvent:event];
        }
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!self.lastTouch || ![touches containsObject:self.lastTouch]) {
        return;
    }
    
    CGPoint location = [self.lastTouch locationInView:self];
    
    if (!CGRectContainsPoint(self.clearButton.frame, location)) {
        LPYNumberButton *clearButton = (id)self.clearButton;
        [clearButton lpy_touchesCancelled:touches withEvent:event];
        
        // 禁止清除按钮长按操作
        _clearButtonLongPressGesture = NO;
    }
    
    if (!CGRectContainsPoint(self.leftButton.frame, location)) {
        [self.leftButton lpy_touchesCancelled:touches withEvent:event];
    }
    
    for (LPYNumberButton *btn in self.numberButtons) {
        btn.highlighted = CGRectContainsPoint(btn.frame, location);
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!self.lastTouch || ![touches containsObject:self.lastTouch]) {
        return;
    }
    
    [self performLastTouchAction];
    
    self.lastTouch = nil;
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.leftButton.highlighted = NO;
    self.clearButton.highlighted = NO;
    
    for (LPYNumberButton *btn in self.numberButtons) {
        btn.highlighted = NO;
    }
    
    self.lastTouch = nil;
}

- (void)performLastTouchAction {
    CGPoint location = [self.lastTouch locationInView:self];
    
    for (LPYNumberButton *btn in self.numberButtons) {
        btn.highlighted = NO;
        if (CGRectContainsPoint(btn.frame, location)) {
            [self btn_NumberButtonClick:btn];
        }
    }
}

- (void)btn_NumberButtonClick:(UIButton *)sender {
    if (!self.textInput) {
        return;
    }
    
    NSString *text = sender.currentTitle;
    
    if (_delegateFlags.textInputSupportsShouldChangeTextInRange) {
        if ([self.textInput shouldChangeTextInRange:self.textInput.selectedTextRange replacementText:text]) {
            [self.textInput insertText:text];
        }
    } else if (_delegateFlags.delegateSupportsTextFieldShouldChangeCharactersInRange) {
        NSRange selectedRange = [[self class] selectedRange:self.textInput];
        UITextField *textField = (UITextField *)self.textInput;
        if ([textField.delegate textField:textField shouldChangeCharactersInRange:selectedRange replacementString:text]) {
            [self.textInput insertText:text];
        }
    } else if (_delegateFlags.delegateSupportsTextViewShouldChangeTextInRange) {
        NSRange selectedRange = [[self class] selectedRange:self.textInput];
        UITextView *textView = (UITextView *)self.textInput;
        if ([textView.delegate textView:textView shouldChangeTextInRange:selectedRange replacementText:text]) {
            [self.textInput insertText:text];
        }
    } else {
        [self.textInput insertText:text];
    }
}

+ (NSRange)selectedRange:(id<UITextInput>)textInput {
    UITextRange *textRange = [textInput selectedTextRange];
    
    NSInteger startOffset = [textInput offsetFromPosition:textInput.beginningOfDocument toPosition:textRange.start];
    NSInteger endOffset = [textInput offsetFromPosition:textInput.beginningOfDocument toPosition:textRange.end];
    
    return NSMakeRange(startOffset, endOffset - startOffset);
}

#pragma mark - 数字按钮
- (LPYNumberButton *)numberButton:(int)number {
    LPYNumberButton *btn = [LPYNumberButton buttonWithBackgroundColor:[self.styleClass numberButtonBackgroundColor] highlightedColor:[self.styleClass numberButtonHighlightedColor]];
    [btn setTitleColor:[self.styleClass numberButtonTextColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [self.styleClass numberButtonFont];
    [btn setTitle:[NSString stringWithFormat:@"%d", number] forState:UIControlStateNormal];
    return btn;
}

- (LPYNumberButton *)functionButton {
    LPYNumberButton *btn = [LPYNumberButton buttonWithBackgroundColor:[self.styleClass functionButtonBackgroundColor] highlightedColor:[self.styleClass functionButtonHighlightedColor]];
    btn.exclusiveTouch = YES;
    return btn;
}

#pragma mark - 通知
- (void)addNotificationsObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidEndEditing:) name:UITextViewTextDidEndEditingNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)textDidBeginEditing:(NSNotification *)notification {
    if (![notification.object conformsToProtocol:@protocol(UITextInput)]) {
        return;
    }
    
    UIResponder<UITextInput> *textInput = notification.object;
    
    if (textInput.inputView && self == textInput.inputView) {
        self.textInput = textInput;
        
        _delegateFlags.textInputSupportsShouldChangeTextInRange = NO;
        _delegateFlags.delegateSupportsTextFieldShouldChangeCharactersInRange = NO;
        _delegateFlags.delegateSupportsTextViewShouldChangeTextInRange = NO;
        
        if ([self.textInput respondsToSelector:@selector(shouldChangeTextInRange:replacementText:)]) {
            _delegateFlags.textInputSupportsShouldChangeTextInRange = YES;
        } else if ([self.textInput isKindOfClass:[UITextField class]]) {
            id<UITextFieldDelegate> delegate = [(UITextField *)self.textInput delegate];
            
            if ([delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
                _delegateFlags.delegateSupportsTextFieldShouldChangeCharactersInRange = YES;
            }
        } else if ([self.textInput isKindOfClass:[UITextView class]]) {
            id<UITextViewDelegate> delegate = [(UITextView *)self.textInput delegate];
            
            if ([delegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
                _delegateFlags.delegateSupportsTextViewShouldChangeTextInRange = YES;
            }
        }
    }
}

- (void)textDidEndEditing:(NSNotification *)notification {
    self.textInput = nil;
}

#pragma mark - 默认赋值
- (void)setStyleClass:(Class<LPYNumberPadStyle>)styleClass {
    if (styleClass) {
        _styleClass = styleClass;
    } else {
        _styleClass = [LPYNumberPadDefaultStyle class];
    }
}

- (UIButton *)leftFunctionButton {
    return self.leftButton;
}
@end
