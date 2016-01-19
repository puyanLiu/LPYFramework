//
//  LPYStrategyViewController.m
//  LPYFramework
//
//  Created by admin on 16/1/15.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYStrategyViewController.h"
#import "LPYCustomField.h"
#import "UIButton+inits.h"

#import "LPYEmailValidator.h"
#import "LPYPhoneNumberValidator.h"

#define Width [UIScreen mainScreen].bounds.size.width

@interface LPYStrategyViewController () <UITextFieldDelegate>
// 输入邮箱的验证框
@property (nonatomic, strong) LPYCustomField *txt_Email;
// 输入电话号码的验证框
@property (nonatomic, strong) LPYCustomField *txt_PhoneNumber;
@end

@implementation LPYStrategyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initButton];
    
    [self initCustomFields];
}

- (void)initButton {
    UIButton *button = [UIButton createButtonWithFrame:CGRectMake(30, 130, 90, 30) buttonType:0 title:@"Back" tag:0 target:self action:@selector(buttonsEvent)];
    [self.view addSubview:button];
}

- (void)buttonsEvent {
    [self.view endEditing:YES];
    
    for (LPYCustomField *textField in self.view.subviews) {
        if ([textField isKindOfClass:[LPYCustomField class]]) {
            if (![textField validate]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:textField.validator.errorMessage delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alert show];
                return;
            }
        }
    }
}

- (void)initCustomFields {
    self.txt_Email = [[LPYCustomField alloc] initWithFrame:CGRectMake(30, 180, Width - 60, 30)];
    self.txt_Email.placeholder = @"请输入邮箱";
    self.txt_Email.delegate = self;
    self.txt_Email.validator = [LPYEmailValidator new];
    [self.view addSubview:self.txt_Email];
    
    self.txt_PhoneNumber = [[LPYCustomField alloc] initWithFrame:CGRectMake(30, 180 + 40, Width - 60, 30)];
    self.txt_PhoneNumber.placeholder = @"请输入电话号码";
    self.txt_PhoneNumber.delegate = self;
    self.txt_PhoneNumber.validator = [LPYPhoneNumberValidator new];
    [self.view addSubview:self.txt_PhoneNumber];
}

#pragma mark - 文本框代理
- (void)textFieldDidEndEditing:(UITextField *)textField {
//    LPYCustomField *customField = (LPYCustomField *)textField;
//    if (![customField validate]) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:customField.validator.errorMessage delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [alert show];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
