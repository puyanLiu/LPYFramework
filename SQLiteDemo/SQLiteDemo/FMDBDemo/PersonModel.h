//
//  PersonModel.h
//  SQLiteDemo
//
//  Created by liupuyan on 16/10/9.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "BaseModel.h"

@interface PersonModel : BaseModel
@property (nonatomic,assign)BOOL  isHave;
@property (nonatomic,assign)NSInteger num;
@property (nonatomic,copy)  NSString * name;
@property (nonatomic,copy)  NSArray * arr;
@property (nonatomic,copy)  NSDictionary * dic;
@property (nonatomic,copy)  NSNumber * age;


@end
