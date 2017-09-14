//
//  RN2ViewController.m
//  CommunicationDemo
//
//  Created by admin on 16/8/29.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "RN2ViewController.h"
#import "RCTBundleURLProvider.h"
#import "RCTRootView.h"

@interface RN2ViewController ()

@end

@implementation RN2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
  
  // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction:) name:@"RNBackOCNotification" object:nil];
  
    NSURL *jsCodeLocation;
    jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"shop.ios" fallbackResource:nil];
    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation moduleName:@"ShopDemo" initialProperties:nil launchOptions:nil];
    rootView.backgroundColor = [[UIColor alloc] initWithRed:0.8f green:0.8f blue:0.0f alpha:1];
    self.view  = rootView;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  self.navigationController.navigationBar.hidden = YES;
  // 去掉背景图片
  [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]  init] forBarMetrics:UIBarMetricsDefault];
  // 去掉底部线条
  [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  self.navigationController.navigationBar.hidden = NO;
  [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
  [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)notificationAction: (NSNotification *)notification {
  NSLog(@"通知------%@", notification);
//  NSString *className = notification.object;
//  Class VCClass = NSClassFromString(className);
//  UIViewController *VC = [[VCClass alloc] init];
//  [self.navigationController pushViewController:VC animated:YES];
  
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
