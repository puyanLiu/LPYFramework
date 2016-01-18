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
#import "LPYBussinessCardViewController.h"
#import "LPYStrategyViewController.h"
#import "LPYOberverPatternViewController.h"
#import "LPYNotificationCenterAndKVOViewController.h"

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

// 适配器模式
- (IBAction)btn_AdapterPatternClick {
    LPYBussinessCardViewController *VC = [[LPYBussinessCardViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

// 策略模式
- (IBAction)btn_StrategyPatternClick {
    LPYStrategyViewController *VC = [[LPYStrategyViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

// app跳转到相应应用
- (IBAction)btn_AppJumpClick {
    // 跳转到相应的应用
    // scheme://identifier 协议头://路径
    NSString *scheme = @"queqianme";
    NSString *identifier = @"com.queqianme.app";
    NSString *path = [NSString stringWithFormat:@"%@%@%@",scheme ,scheme ? @"://" : @"", identifier];
    NSURL *url = [NSURL URLWithString:path];
    
    UIApplication *application = [UIApplication sharedApplication];
    
    NSString *appUrl = @"http://itunes.apple.com/app/id1031465316?mt=8";
    // 判断是否有安装应用
    if([application canOpenURL:url])
    {
        [application openURL:url];
    }
    else
    {
        // 打开appstore地址
        [application openURL:[NSURL URLWithString:appUrl]];
    }
}

// 观察者模式
- (IBAction)btn_ObserverPatternClick {
    LPYOberverPatternViewController *VC = [[LPYOberverPatternViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

// 通知中心与KVO
- (IBAction)btn_NotificationCenterAndKVOClick {
    LPYNotificationCenterAndKVOViewController *VC = [[LPYNotificationCenterAndKVOViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}


@end
