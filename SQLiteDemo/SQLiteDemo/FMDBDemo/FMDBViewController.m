//
//  FMDBViewController.m
//  SQLiteDemo
//
//  Created by liupuyan on 16/10/9.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "FMDBViewController.h"
#import "QQMDataManager.h"
#import "PersonModel.h"

@interface FMDBViewController ()

@end

@implementation FMDBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    QQMDataManager * manager = [QQMDataManager managerWithTable:@"PersonModel"];
    PersonModel * model = [[PersonModel alloc]init];
    model.name = @"0";
    model.isHave = 1;
    model.num = 20;
    model.arr = @[@"arr",@"arr"];
    model.dic = @{
                  @"dic":@"dic123"
                  };
    model.age = @(20);
    //插入
    [manager insert:model];
    
//    //更新
//    [manager update:model withMainKey:@"name"];
//    //删除
//    [manager remove:model withMainKey:@"name"];
//    [manager removeAll:@"PersonModel"];
//    //查询
//    PersonModel * model2 = (PersonModel *)[manager fetch:@{
//                                                           W_TABLE_NAME:@"PersonModel",
//                                                           @"name":@"0",
//                                                           @"num":@(10)
//                                                           }].lastObject;
    NSLog(@"%@",[manager fetchAll:@"PersonModel"]);
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
