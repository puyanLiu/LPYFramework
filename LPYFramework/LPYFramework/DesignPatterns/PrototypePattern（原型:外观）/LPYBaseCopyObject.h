//
//  LPYBaseCopyObject.h
//  LPYFramework
//
//  Created by admin on 16/1/26.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPYBaseCopyObject : NSObject <NSCopying>

/**
 *  子类需要重载实现
 *
 *  @param object 复制的对象
 */
- (void)copyOperationWithObject:(id)object;

@end
