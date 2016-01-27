
//
//  LPYTeacherModel.m
//  LPYFramework
//
//  Created by admin on 16/1/26.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYTeacherModel.h"

@implementation LPYTeacherModel
- (void)copyOperationWithObject:(LPYTeacherModel *)object {
    object.name = self.name;
    object.age = self.age;
}
@end
