//
//  LPYMainViewController.m
//  LPYFramework
//
//  Created by admin on 16/1/18.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYMainViewController.h"
#import "LPYInfiniteScrollViewController.h"
#import "LPYQRCodeViewController.h"
#import "LPYQRCodeScanningViewController.h"
#import "LPYLightShowViewController.h"
#import "LPYPasswordKeyBoardViewController.h"
#import "LPYBussinessCardViewController.h"
#import "LPYStrategyViewController.h"
#import "LPYOberverPatternViewController.h"
#import "LPYNotificationCenterAndKVOViewController.h"
#import "LPYGesturesUnlockViewController.h"
#import "LPYTouchIDViewController.h"
#import "LPYPrototypePatternViewController.h"
#import "LPYDecoratorPatternViewController.h"
#import "LPYFactoryPatternViewController.h"


#import "LPYADView.h"
#import "LPYADViewController.h"

@interface LPYMainViewController ()

@end

@implementation LPYMainViewController



- (void)viewDidLoad {
    // 广告
    [self showAdView];
}

// 广告
- (void)showAdView {
    //    NSString *imageUrl =  @"http://img4q.duitang.com/uploads/item/201408/18/20140818140642_yQZwB.jpeg";
    //    NSString *imageUrl = @"http://imgsrc.baidu.com/forum/pic/item/9213b07eca80653846dc8fab97dda144ad348257.jpg";
    //    NSString *imageUrl = @"http://www.mangowed.com/uploads/allimg/130410/1-130410215449417.jpg";
    
    
//    NSString *imageUrl = @"http://img5.pcpop.com/ArticleImages/picshow/0x0/20110801/2011080114495843125.jpg";
    NSString *imageUrl = @"http://img5.duitang.com/uploads/item/201501/05/20150105184318_w8HPK.jpeg";
//    NSString *imageUrl = @"http://img5q.duitang.com/uploads/item/201505/25/20150525223238_NdQrh.thumb.700_0.png";
    NSString *adURL = @"http://www.baidu.com/";
    __weak typeof(self) weakSelf = self;
    // 创建广告
    LPYADView *adView = [[LPYADView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds imgUrl:imageUrl adUrl:adURL clickImgBlock:^(NSString *clickImgUrl) {
        NSLog(@"进入广告：%@", clickImgUrl);
        LPYADViewController *adVC = [[LPYADViewController alloc] init];
        adVC.adUrl = clickImgUrl;
        [weakSelf.navigationController pushViewController:adVC animated:YES];
    }];
    
    // 设置倒计时
    adView.showTime = 10;
    
    // 显示广告
    [adView show];
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

// 手势解锁
- (IBAction)btn_GesturesUnlockClick {
    LPYGesturesUnlockViewController *VC = [[LPYGesturesUnlockViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

// TouchID验证
- (IBAction)btn_TouchIDClick {
    LPYTouchIDViewController *VC = [[LPYTouchIDViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

// 原型外观
- (IBAction)btn_PrototypePatternClick {
    LPYPrototypePatternViewController *VC = [[LPYPrototypePatternViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

// 装饰模式
- (IBAction)btn_DecoratorPatternClick {
    LPYDecoratorPatternViewController *VC = [[LPYDecoratorPatternViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

// 工厂模式
- (IBAction)btn_FactoryPatternClick {
    LPYFactoryPatternViewController *VC = [[LPYFactoryPatternViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

@end
