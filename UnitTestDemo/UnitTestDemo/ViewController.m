//
//  ViewController.m
//  UnitTestDemo
//
//  Created by admin on 16/4/19.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txt_UserName;
@property (weak, nonatomic) IBOutlet UITextField *txt_Password;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn_LoginClick {
    NSString *username = self.txt_UserName.text;
    NSString *password = self.txt_Password.text;
    if (![username isEqualToString:@"admin"]) {
        [self alertMessage:@"用户名输入错误"];
    } else if (![password isEqualToString:@"666666"]) {
        [self alertMessage:@"密码输入错误"];
    } else {
        [self alertMessage:@"登录成功"];
    }
}

- (void)alertMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *know = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:know];
    [self presentViewController:alert animated:YES completion:nil];
}

- (int)getNum {
    return 100;
}

@end
