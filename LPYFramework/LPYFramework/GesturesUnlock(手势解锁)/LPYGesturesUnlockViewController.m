//
//  LPYGesturesUnlockViewController.m
//  LPYFramework
//
//  Created by admin on 16/1/18.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYGesturesUnlockViewController.h"
#import "LPYGestureViewController.h"
#import "LPYCircleViewConst.h"
#import "LPYGestureVertifyViewController.h"

@interface LPYGesturesUnlockViewController ()

@end

@implementation LPYGesturesUnlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"手势解锁";
    
    [self setupUI];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn1 setTitle:@"设置手势密码" forState:UIControlStateNormal];
    btn1.frame = CGRectMake(50, 100, 150, 30);
    btn1.tag = 1;
    [btn1 addTarget:self action:@selector(btn_Click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn2 setTitle:@"登录手势密码" forState:UIControlStateNormal];
    btn2.frame = CGRectMake(50, 150, 150, 30);
    btn2.tag = 2;
    [btn2 addTarget:self action:@selector(btn_Click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn3 setTitle:@"验证手势密码" forState:UIControlStateNormal];
    btn3.frame = CGRectMake(50, 200, 150, 30);
    btn3.tag = 3;
    [btn3 addTarget:self action:@selector(btn_Click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn4 setTitle:@"修改手势密码" forState:UIControlStateNormal];
    btn4.frame = CGRectMake(50, 250, 150, 30);
    btn4.tag = 4;
    [btn4 addTarget:self action:@selector(btn_Click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
}

- (void)btn_Click:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
        {
            LPYGestureViewController *VC = [[LPYGestureViewController alloc] init];
            VC.type = LPYGestureViewControllerTypeSetting;
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 2:
        {
            if ([[LPYCircleViewConst getGestureWithKey:gestureFinalSaveKey] length]) {
                LPYGestureViewController *gestureVc = [[LPYGestureViewController alloc] init];
                [gestureVc setType:LPYGestureViewControllerTypeLogin];
                [self.navigationController pushViewController:gestureVc animated:YES];
            } else {
                UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"暂未设置手势密码，是否前往设置" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
                [alerView show];
            }
        }
            break;
        case 3:
        {
            LPYGestureVertifyViewController *gestureVerifyVc = [[LPYGestureVertifyViewController alloc] init];
            [self.navigationController pushViewController:gestureVerifyVc animated:YES];
        }
            break;
        case 4:
        {
            LPYGestureVertifyViewController *gestureVerifyVc = [[LPYGestureVertifyViewController alloc] init];
            gestureVerifyVc.isToSetNewGesture = YES;
            [self.navigationController pushViewController:gestureVerifyVc animated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        LPYGestureViewController *gestureVc = [[LPYGestureViewController alloc] init];
        gestureVc.type = LPYGestureViewControllerTypeSetting;
        [self.navigationController pushViewController:gestureVc animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
