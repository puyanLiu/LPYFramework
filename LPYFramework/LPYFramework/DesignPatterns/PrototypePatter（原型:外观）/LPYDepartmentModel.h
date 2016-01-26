//
//  LPYDepartmentModel.h
//  LPYFramework
//
//  Created by admin on 16/1/26.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYBaseCopyObject.h"

@interface LPYDepartmentModel : LPYBaseCopyObject
/**
 *  name
 */
@property (nonatomic, strong) NSString *name;
/**
 *  老师
 */
@property (nonatomic, strong) NSArray *teachers;
@end
