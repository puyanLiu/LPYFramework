//
//  LPYNotificationCenterAndKVOViewController.m
//  LPYFramework
//
//  Created by admin on 16/1/18.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYNotificationCenterAndKVOViewController.h"
#import "LPYKVOModel.h"

#define SCIENCE @"SCIENCE"

@interface LPYNotificationCenterAndKVOViewController ()
// model
@property (nonatomic, strong) LPYKVOModel *model;
@end

@implementation LPYNotificationCenterAndKVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 添加客户到指定的订阅号中
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationCenter:) name:SCIENCE object:nil];
    
    // 发送消息到指定的订阅号当中
    [[NSNotificationCenter defaultCenter] postNotificationName:SCIENCE object:@"V1.0"];
    
    
    // 创建订阅号
    self.model = [[LPYKVOModel alloc] init];
    // 客户添加了订阅中心的“name”服务
    [self.model addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    // 订阅中心发送消息（通过修改属性）
    self.model.name = @"V1.0";
}

#pragma mark - 通知中心方法
- (void)notificationCenter:(id)sender {
    NSLog(@"%@", sender);
}

#pragma mark - KVO方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    NSLog(@"KVO------%@", change);
}

#pragma mark - 释放资源
- (void)dealloc {
    // 移除通知中心
    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:SCIENCE];
    
    // 移除KVO
    [self.model removeObserver:self forKeyPath:@"name"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
