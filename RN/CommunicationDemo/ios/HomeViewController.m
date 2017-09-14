//
//  HomeViewController.m
//  CommunicationDemo
//
//  Created by admin on 16/8/26.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "HomeViewController.h"
#import "RNViewController.h"
#import "RN2ViewController.h"
#import "RN3ViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn_PushRNClick {
    RNViewController *VC = [[RNViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}


- (IBAction)btn_PushRN2Click {
  RN2ViewController *VC = [[RN2ViewController alloc] init];
  [self.navigationController pushViewController:VC animated:YES];
}

- (IBAction)btn_PushRN3Click {
  RN3ViewController *VC = [[RN3ViewController alloc] init];
  [self.navigationController pushViewController:VC animated:YES];
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
