//
//  DataBaseTool.h
//  SQLiteDemo
//
//  Created by liupuyan on 16/10/8.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StudentModel.h"

@interface DataBaseTool : NSObject
/**
 *  添加学生
 *
 *  @param student 需要添加的学生
 */
+ (BOOL)addStudent:(StudentModel *)student;

/**
 *  获得所有的学生
 *
 *  @return 数组中装着都是IWStudent模型
 */
+ (NSArray *)students;

/**
 *  根据搜索条件获得对应的学生
 *
 *  @param condition 搜索条件
 */
+ (NSArray *)studentsWithCondition:(NSString *)condition;
@end
