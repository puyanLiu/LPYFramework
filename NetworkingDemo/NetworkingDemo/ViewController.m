//
//  ViewController.m
//  NetworkingDemo
//
//  Created by liupuyan on 16/9/22.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)btn_GetCurrentReachability:(id)sender {
    AFNetworkReachabilityManager *reach = [AFNetworkReachabilityManager sharedManager];
    [reach setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSString * tips = @"";
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                tips = @"无网络连接";
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                tips = @"手机网络";
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                tips = @"wifi";
                break;
            case AFNetworkReachabilityStatusUnknown:
                tips = @"未知网络";
                break;
            default:
                break;
        }
        
        
        NSLog(@"tips = %@",tips);
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"当前网络状态为:%@",tips] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * aa = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [ac dismissViewControllerAnimated:YES completion:nil];
        }];
        [ac addAction:aa];
        [self presentViewController:ac animated:YES completion:nil];
    }];
    [reach startMonitoring];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
