//
//  PersonModel2.m
//  SQLiteDemo
//
//  Created by liupuyan on 16/10/9.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "PersonModel2.h"

@implementation PersonModel2 

// 用过JSONModel的都明白这个写法
- (NSDictionary *)fmdbPropertyMapping
{
    return @{
             @"name_sql" : @"name",
             @"gender_sql" : @"gender",
             @"age_sql" : @"age",
             @"weight_sql" : @"weight",
             @"height_sql" : @"height",
             @"married_sql" : @"married"
             };
}

@end
