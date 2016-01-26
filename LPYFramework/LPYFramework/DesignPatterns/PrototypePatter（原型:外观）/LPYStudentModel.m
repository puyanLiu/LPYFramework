
//
//  LPYStudentModel.m
//  LPYFramework
//
//  Created by admin on 16/1/26.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYStudentModel.h"

@implementation LPYStudentModel

- (id)clone {
    LPYStudentModel *model = [[[self class] alloc] init];
    
    // 完成复杂操作的所有作业
    model.name = self.name;
    model.age = self.age;
    model.address = self.address;
    model.totalScore = self.totalScore;
    
    return model;
}
@end
