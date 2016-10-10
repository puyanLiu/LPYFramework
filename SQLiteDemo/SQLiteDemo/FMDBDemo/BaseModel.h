//
//  BaseModel.h
//  SQLiteDemo
//
//  Created by liupuyan on 16/10/9.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

typedef NS_ENUM(NSInteger, DataType) {
    wBOOL = 0,
    wTEXT = 1,
    wINT  = 2,
    wArr = 3,
    wDic = 4,
    wERROR = 999,
};

- (NSDictionary *)allMembers;

@end
