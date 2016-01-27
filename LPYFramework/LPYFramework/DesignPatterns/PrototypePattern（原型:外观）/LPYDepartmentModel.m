
//
//  LPYDepartmentModel.m
//  LPYFramework
//
//  Created by admin on 16/1/26.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYDepartmentModel.h"

@implementation LPYDepartmentModel
- (void)copyOperationWithObject:(LPYDepartmentModel *)object {
    object.name = self.name;
    // 完成了深拷贝 完整的复制了集合里面的对象
    object.teachers = [[NSArray alloc] initWithArray:self.teachers copyItems:YES];
}
@end
