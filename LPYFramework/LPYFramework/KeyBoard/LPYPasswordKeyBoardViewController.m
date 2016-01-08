//
//  LPYPasswordKeyBoardViewController.m
//  LPYFramework
//
//  Created by admin on 16/1/8.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYPasswordKeyBoardViewController.h"

@interface LPYPasswordKeyBoardViewController ()

@end

@implementation LPYPasswordKeyBoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor grayColor];
    UITextField *txt = [[UITextField alloc] init];
    txt.frame = CGRectMake(100, 100, 200, 30);
    txt.backgroundColor = [UIColor whiteColor];
    /*
     UIKeyboardTypeDefault,                // 输入汉字键盘
     UIKeyboardTypeASCIICapable,           // ASCII字符键盘
     UIKeyboardTypeNumbersAndPunctuation,  // 数字和各种字符键盘
     UIKeyboardTypeURL,                    // 输入URL键盘
     UIKeyboardTypeNumberPad,              // 数字不含小数点键盘（数字下边包含英文字母）
     UIKeyboardTypePhonePad,               // 电话号码键盘
     UIKeyboardTypeNamePhonePad,           // 输入联系人或电话号码
     UIKeyboardTypeEmailAddress,           // 输入电子邮件
     UIKeyboardTypeDecimalPad,             // 数字含小数点键盘（数字下边包含英文字母）
     UIKeyboardTypeTwitter,                // 输入Twitter键盘
     UIKeyboardTypeWebSearch ,             // 搜索框键盘
     */
    txt.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:txt];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
