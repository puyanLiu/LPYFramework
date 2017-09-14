//
//  RNViewController.m
//  CommunicationDemo
//
//  Created by admin on 16/8/26.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "RNViewController.h"
#import "RCTBundleURLProvider.h"
#import "RCTRootView.h"

@interface RNViewController ()

@end

@implementation RNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    self.title = @"React Native界面";
  
  NSDictionary *proper = @{@"containerVC": [self class]};
  
    NSURL *jsCodeLocation;
    jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index.ios" fallbackResource:nil];
    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation moduleName:@"CommunicationDemo" initialProperties:proper launchOptions:nil];
    rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];
    self.view  = rootView;
}

@end
