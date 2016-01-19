//
//  LPYOberverPatternViewController.m
//  LPYFramework
//
//  Created by admin on 16/1/18.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYOberverPatternViewController.h"
#import "LPYSubscriptionServiceCenter.h"

static NSString *SCIENCE = @"SCIENCE";

@interface LPYOberverPatternViewController () <LPYSubscriptionServiceCenterProtocol>

@end

@implementation LPYOberverPatternViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 创建订阅号
    [LPYSubscriptionServiceCenter createSubscriptionNumber:SCIENCE];
    
    // 添加订阅的用户到指定的刊物
    [LPYSubscriptionServiceCenter addCustomer:self withSubscriptionNumber:SCIENCE];
    
    // 发行机构发送消息
    [LPYSubscriptionServiceCenter sendMessage:@"V1.0" toSubscriptionNumber:SCIENCE];
}

- (void)subscriptionMessage:(id)message subscriptionNumber:(NSString *)subscriptionNumber {
    NSLog(@"%@  %@", message, subscriptionNumber);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
