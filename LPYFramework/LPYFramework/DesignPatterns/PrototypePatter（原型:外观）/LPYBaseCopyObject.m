//
//  LPYBaseCopyObject.m
//  LPYFramework
//
//  Created by admin on 16/1/26.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYBaseCopyObject.h"

@implementation LPYBaseCopyObject

/**
 *  基类重载
 *
 *  @param zone
 *
 *  @return 返回复制的对象
 */
- (id)copyWithZone:(NSZone *)zone {
    LPYBaseCopyObject *copyObject = [[self class] allocWithZone:zone];
    
    [self copyOperationWithObject:copyObject];
    
    return copyObject;
}

- (void)copyOperationWithObject:(id)object {
    
}
@end
