//
//  LPYGestureVertifyViewController.m
//  LPYFramework
//
//  Created by admin on 16/1/18.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYGestureVertifyViewController.h"
#import "LPYCircleViewConst.h"
#import "LPYCircleView.h"
#import "LPYLockLabel.h"
#import "LPYGestureViewController.h"

@interface LPYGestureVertifyViewController () <LPYCircleViewDelegate>
/**
 *  文字提示Label
 */
@property (nonatomic, strong) LPYLockLabel *msgLabel;
@end

@implementation LPYGestureVertifyViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.view setBackgroundColor:CircleViewBackgroundColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"验证手势解锁";
    
    LPYCircleView *lockView = [[LPYCircleView alloc] init];
    lockView.delegate = self;
    [lockView setType:LPYCircleViewTypeVerify];
    [self.view addSubview:lockView];
    
    LPYLockLabel *msgLabel = [[LPYLockLabel alloc] init];
    msgLabel.frame = CGRectMake(0, 0, kScreenW, 14);
    msgLabel.center = CGPointMake(kScreenW/2, CGRectGetMinY(lockView.frame) - 30);
    [msgLabel showNormalMsg:gestureTextOldGesture];
    self.msgLabel = msgLabel;
    [self.view addSubview:msgLabel];
}

#pragma mark - login or verify gesture
- (void)circleView:(LPYCircleView *)view type:(LPYCircleViewType)type didCompleteLoginGesture:(NSString *)gesture result:(BOOL)equal
{
    if (type == LPYCircleViewTypeVerify) {
        
        if (equal) {
            NSLog(@"验证成功");
            
            if (self.isToSetNewGesture) {
                LPYGestureViewController *gestureVc = [[LPYGestureViewController alloc] init];
                [gestureVc setType:LPYGestureViewControllerTypeSetting];
                [self.navigationController pushViewController:gestureVc animated:YES];
            } else {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            
        } else {
            NSLog(@"密码错误！");
            [self.msgLabel showWarnMsgAndShake:gestureTextGestureVerifyError];
        }
    }
}
@end
