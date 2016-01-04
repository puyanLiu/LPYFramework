//
//  LPYInfiniteScrollViewController.m
//  LPYFramework
//
//  Created by 刘蒲艳 on 16/1/4.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYInfiniteScrollViewController.h"
#import "LPYInfiniteScrollView.h"

@interface LPYInfiniteScrollViewController ()

@end

@implementation LPYInfiniteScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    LPYInfiniteScrollView *scrollView = [[LPYInfiniteScrollView alloc] init];
    scrollView.frame = CGRectMake(30, 100, 300, 130);
    scrollView.images = @[
                          [UIImage imageNamed:@"img_00"],
                          [UIImage imageNamed:@"img_01"],
                          [UIImage imageNamed:@"img_02"],
                          [UIImage imageNamed:@"img_03"],
                          [UIImage imageNamed:@"img_04"]
                          ];
    scrollView.pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    scrollView.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    [self.view addSubview:scrollView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
