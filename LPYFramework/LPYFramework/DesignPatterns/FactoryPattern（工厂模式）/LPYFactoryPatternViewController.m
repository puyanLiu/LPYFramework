//
//  LPYFactoryPatternViewController.m
//  LPYFramework
//
//  Created by admin on 16/1/27.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYFactoryPatternViewController.h"
#import "LPYDeviceFactory.h"

#import "LPYFactoryManager.h"

@interface LPYFactoryPatternViewController ()

@end

@implementation LPYFactoryPatternViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self simpleFactoryPattern];
    
    [self abstractFactoryPattern];
}

- (void)abstractFactoryPattern {
    // 获取工厂
    LPYBaseFactory *factory = [LPYFactoryManager factoryWithBrand:kApple];
    
    // 创建商品
    LPYBasePhone *phone = [factory createPhone];
    LPYBaseWatch *watch = [factory createWatch];
    
    NSLog(@"%@ %@", phone, watch);
}

- (void)simpleFactoryPattern {
    
    // 工厂中创建出具体产品
    LPYiPhoneDevice *iPhone = (LPYiPhoneDevice *)[LPYDeviceFactory deviceFactoryWithDeviceType:kiPhone];
    
    // 使用产品的功能
    [iPhone fingerprintIdentification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
