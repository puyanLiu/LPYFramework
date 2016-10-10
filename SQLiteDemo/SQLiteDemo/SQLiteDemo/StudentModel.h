//
//  StudentModel.h
//  SQLiteDemo
//
//  Created by liupuyan on 16/10/8.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StudentModel : NSObject
@property (nonatomic, assign) int ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int age;
@end
