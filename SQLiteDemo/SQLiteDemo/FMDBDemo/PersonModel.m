//
//  PersonModel.m
//  SQLiteDemo
//
//  Created by liupuyan on 16/10/9.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "PersonModel.h"

@implementation PersonModel
- (NSString *)description {
    return [NSString stringWithFormat:@"name:%@ ishave:%d num:%ld arr:%@ dic:%@",self.name,self.isHave,(long)self.num,self.arr,self.dic];
}
@end
