//
//  RN3ViewController.m
//  CommunicationDemo
//
//  Created by liupuyan on 16/9/13.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "RN3ViewController.h"
#import "RCTBundleURLProvider.h"
#import "RCTRootView.h"

@interface RN3ViewController ()

@end

@implementation RN3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    NSURL *jsCodeLocation;
    jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index2.ios" fallbackResource:nil];
    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation moduleName:@"CalendarDemo" initialProperties:nil launchOptions:nil];
    rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];
    self.view  = rootView;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
