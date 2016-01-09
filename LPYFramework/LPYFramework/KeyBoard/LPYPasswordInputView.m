//
//  LPYPasswordInputViewController.m
//  LPYFramework
//
//  Created by admin on 16/1/9.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYPasswordInputView.h"
#import "LPYNumberPad.h"

#define LPYKeyWindow [UIApplication sharedApplication].keyWindow
// 获取屏幕高度
#define LPYWindowH [UIScreen mainScreen].bounds.size.height
// 获取屏幕宽度
#define LPYWindowW [UIScreen mainScreen].bounds.size.width
// 密码个数
#define PwdCount 6

#define contentH self.contentView.frame.size.height

@interface LPYPasswordInputView () <LPYNumberPadDelegate>
// UIView
@property (nonatomic, strong) UIView *contentView;
// 隐藏文本框
@property (nonatomic, strong) UITextField *hideTextField;
// 密码容器
@property (nonatomic, strong) UIView *passwordView;
@end

@implementation LPYPasswordInputView

- (void)awakeFromNib {
}

- (instancetype)init
{
    if(self = [super init])
    {
        self.frame = [UIScreen mainScreen].bounds;
        
        [self customeView];
    }
    return self;
}

- (void)customeView
{
    [self setupBgView];
    [self addObserver];
    
    [self.hideTextField becomeFirstResponder];
}

- (void)addObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillHide:(NSNotification *)note {
    CGFloat animation = [note.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    [UIView animateWithDuration:animation animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)dealloc {
    // 移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    // 移除KVO监听
    for (UITextField *txt in self.passwordView.subviews) {
        [txt removeObserver:self forKeyPath:@"text"];
    }
}

- (void)btn_CancelClick {
    [self hide];
}

- (void)setupBgView {
    // 背景View
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.3;
    bgView.frame = [UIScreen mainScreen].bounds;
    [self addSubview:bgView];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)];
//    [self addGestureRecognizer:tap];
}

- (void)tapGesture {
    [self hide];
}

- (void)show
{
    UIWindow *window = LPYKeyWindow;
    UIView *topView = [window.subviews firstObject];
    [topView addSubview:self];
}

- (void)hide
{
    [self.hideTextField resignFirstResponder];
}

#pragma mark - 监听键盘

- (UIView *)contentView
{
    if(!_contentView)
    {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor grayColor];
        
        CGFloat margin = 15;
        CGFloat topH = 50;
        // 请输入密码
        UILabel *lbl_Info = [[UILabel alloc] init];
        lbl_Info.text = @"请输入密码";
        lbl_Info.font = [UIFont systemFontOfSize:16.0f];
        [lbl_Info sizeToFit];
        lbl_Info.frame = CGRectMake(margin, 0, lbl_Info.frame.size.width, topH);
        [self.contentView addSubview:lbl_Info];
        
        // 取消按钮
        UIButton *btn_Cancel = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn_Cancel setTitle:@"取消" forState:UIControlStateNormal];
        btn_Cancel.titleLabel.font = lbl_Info.font;
        [btn_Cancel addTarget:self action:@selector(btn_CancelClick) forControlEvents:UIControlEventTouchUpInside];
        CGFloat btn_CancelW = 60;
        btn_Cancel.frame = CGRectMake(LPYWindowW - btn_CancelW, 0, btn_CancelW, topH);
        [self.contentView addSubview:btn_Cancel];
        
        // 密码容器
        UIView *passwordView = [[UIView alloc] init];
        CGFloat passwordViewW = LPYWindowW - 2 * margin;
        passwordView.frame = CGRectMake(margin, topH, passwordViewW, topH);
        passwordView.layer.cornerRadius = 5.0f;
        passwordView.clipsToBounds = YES;
        passwordView.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:passwordView];
        self.passwordView = passwordView;
        
        CGFloat seperator = 1.0;
        CGFloat txtW = 1.0 * (passwordViewW - (PwdCount - 1) * seperator) / PwdCount;
        // 密码输入框
        for (int i = 0; i < PwdCount; i++) {
            CGFloat x = (txtW + seperator) * i;
            UITextField *pwdField = [[UITextField alloc] initWithFrame:CGRectMake(x, 0, txtW, topH)];
            pwdField.backgroundColor = [UIColor whiteColor];
            pwdField.textAlignment = NSTextAlignmentCenter;
            [pwdField addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:(__bridge void * _Nullable)(pwdField)];
            pwdField.userInteractionEnabled = NO;
            [passwordView addSubview:pwdField];
        }
        
        CGFloat contentViewH = CGRectGetMaxY(passwordView.frame) + margin;
        self.contentView.frame = CGRectMake(0, 0, LPYWindowW, contentViewH);
    }
    return _contentView;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
}

- (UITextField *)hideTextField
{
    if(!_hideTextField)
    {
        _hideTextField = [[UITextField alloc] init];
        _hideTextField.hidden = YES;
        [_hideTextField addTarget:self action:@selector(hideTextFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
        _hideTextField.inputView = ({
            LPYNumberPad *numberPad = [LPYNumberPad numberPadWithDelegate:self];
            numberPad;
        });
        _hideTextField.inputAccessoryView = self.contentView;
        [self addSubview:_hideTextField];
    }
    return _hideTextField;
}

- (void)hideTextFieldEditingChanged:(UITextField *)sender {
    if (sender.text.length < 7) {
        [self distributionPwd];
        if (sender.text.length == 6) {
            NSLog(@"输入完成");
            [self hide];
        }
    } else {
        sender.text = [sender.text substringWithRange:NSMakeRange(0, sender.text.length - 1)];
    }
}

- (void)distributionPwd {
    for (int i = 0; i < PwdCount; i++) {
        UITextField *txtPwd = self.passwordView.subviews[i];
        if (i < self.hideTextField.text.length) {
            txtPwd.text = [self.hideTextField.text substringWithRange:NSMakeRange(i, 1)];
        } else {
            txtPwd.text = @"";
        }
    }
}

@end
