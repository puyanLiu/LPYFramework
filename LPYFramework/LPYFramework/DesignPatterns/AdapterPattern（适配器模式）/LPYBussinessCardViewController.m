//
//  LPYBussinessCardViewController.m
//  LPYFramework
//
//  Created by admin on 16/1/14.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYBussinessCardViewController.h"

#import "LPYBussinessCardView.h"

#import "LPYBussinessCardModel.h"
#import "LPYBussinessNewCardModel.h"

// 类适配器
#import "LPYBussinessBaseCardAdapter.h"
#import "LPYBussinessCardModelAdapter.h"
#import "LPYBussinessNewCardModelAdapter.h"

// 对象适配器
#import "LPYBussinessCardAdapter.h"

@interface LPYBussinessCardViewController ()

@end

@implementation LPYBussinessCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    LPYBussinessCardView *cardView = [[LPYBussinessCardView alloc] initWithFrame:BUSINESS_FRAME];
    cardView.center = self.view.center;
    
    // 以对象赋值
    LPYBussinessCardModel *model = [[LPYBussinessCardModel alloc] init];
    model.name = @"Peral";
    model.lineColor = [UIColor yellowColor];
    model.phoneNumber = @"101 - 1234 - 000";
    
    LPYBussinessNewCardModel *newModel = [[LPYBussinessNewCardModel alloc] init];
    newModel.name = @"Peral";
    newModel.colorHexString = @"black";
    newModel.phoneNumber = @"101 - 123 - 000";
    
    // 与输入建立联系
    // 类适配器
//    LPYBussinessBaseCardAdapter *adapter = [[LPYBussinessCardModelAdapter alloc] initWithData:model];
//    LPYBussinessBaseCardAdapter *adapter = [[LPYBussinessNewCardModelAdapter alloc] initWithData:newModel];
    
    // 对象适配器
//    LPYBussinessCardAdapter *adapter = [[LPYBussinessCardAdapter alloc] initWithData:model];
    LPYBussinessCardAdapter *adapter = [[LPYBussinessCardAdapter alloc] initWithData:newModel];
    
    // 与输出建立联系
    cardView.bussinessCardData = adapter;
    
    [self.view addSubview:cardView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
