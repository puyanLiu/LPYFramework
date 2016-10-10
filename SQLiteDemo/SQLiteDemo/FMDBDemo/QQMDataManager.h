//
//  QQMDataManager.h
//  SQLiteDemo
//
//  Created by liupuyan on 16/10/9.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

extern NSString * const QQM_TABLE_NAME;
@interface QQMDataManager : NSObject

+ (QQMDataManager *)managerWithTable:(NSString *)modelName;

- (void)insert:(BaseModel *)model;

- (void)update:(BaseModel *)model withMainKey:(NSString *)key;

- (void)remove:(BaseModel *)model;
- (void)remove:(BaseModel *)model withMainKey:(NSString *)key;
- (void)removeAll:(NSString *)tableName;

- (NSArray<BaseModel *> * )fetch:(NSDictionary *)dic;

- (NSArray<BaseModel *> * )fetchAll:(NSString *)modelName;

@end
