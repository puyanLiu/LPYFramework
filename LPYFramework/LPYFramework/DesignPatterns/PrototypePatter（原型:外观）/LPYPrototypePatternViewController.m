//
//  LPYPrototypePatternViewController.m
//  LPYFramework
//
//  Created by admin on 16/1/26.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYPrototypePatternViewController.h"
#import "LPYStudentModel.h"
#import "LPYTeacherModel.h"
#import "LPYDepartmentModel.h"
#import "LPYShapeMaker.h"

@interface LPYPrototypePatternViewController ()

@end

@implementation LPYPrototypePatternViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self prototypeDemo1];
//    [self prototypeDemo2];
    [self draw];
}

- (void)draw {
    // 图形绘制
    [LPYShapeMaker drawCircleWithParas:@{@"radius" : @(10.0)}];
    
    [LPYShapeMaker draCircleAndRectangle:@{@"radius" : @(10.0), @"width" : @(10.0), @"height" : @(5.0)}];
}

- (void)prototypeDemo2 {
    LPYTeacherModel *tea1 = [[LPYTeacherModel alloc] init];
    tea1.name = @"小明";
    
    LPYTeacherModel *tea2 = tea1.copy;
    
    LPYDepartmentModel *dep1 = [[LPYDepartmentModel alloc] init];
    dep1.name = @"部门1";
    dep1.teachers = @[tea1, tea2];
    
    LPYDepartmentModel *dep2 = dep1.copy;
    NSLog(@"%@ %@", dep1, dep2);
    
    NSLog(@"%@ %@", dep1.teachers, dep2.teachers);
}

- (void)prototypeDemo1 {
    LPYStudentModel *stu1 = [[LPYStudentModel alloc] init];
    stu1.name = @"xiaowang";
    stu1.age = @(19);
    stu1.address = @"guangzhou";
    stu1.totalScore = @(100);
    
    LPYStudentModel *stu2 = [stu1 clone];
    stu2.name = @"xiaohong";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
