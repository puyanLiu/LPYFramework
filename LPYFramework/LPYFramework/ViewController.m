//
//  ViewController.m
//  LPYFramework
//
//  Created by 刘蒲艳 on 15/12/23.
//  Copyright © 2015年 liupuyan. All rights reserved.
//

#import "ViewController.h"
#import "LPYInfiniteScrollViewController.h"
#import "LPYQRCodeViewController.h"
#import "LPYQRCodeScanningViewController.h"
#import "LPYLightShowViewController.h"
#import "LPYPasswordKeyBoardViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

// 无限循环
- (IBAction)btn_ScrollViewClick {
    LPYInfiniteScrollViewController *VC = [[LPYInfiniteScrollViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

// 二维码
- (IBAction)btn_QRCodeClick {
    LPYQRCodeViewController *VC = [[LPYQRCodeViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

// 二维码扫描
- (IBAction)btn_QRCodeScanningClick {
    LPYQRCodeScanningViewController *VC = [[LPYQRCodeScanningViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

// 开关灯
- (IBAction)btn_LightClick {
    LPYLightShowViewController *VC = [[LPYLightShowViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

// 弹出密码键盘
- (IBAction)btn_PasswordKeyBoardClick {
    LPYPasswordKeyBoardViewController *VC = [[LPYPasswordKeyBoardViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

@end
