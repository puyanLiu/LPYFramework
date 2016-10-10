//
//  PersonModel2.h
//  SQLiteDemo
//
//  Created by liupuyan on 16/10/9.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDBPropertyMappingDelegate.h"

@interface PersonModel2 : NSObject <FMDBPropertyMappingDelegate>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, assign) NSUInteger age;
@property (nonatomic, assign) float weight;
@property (nonatomic, assign) double height;
@property (nonatomic, assign) BOOL married;

@end
