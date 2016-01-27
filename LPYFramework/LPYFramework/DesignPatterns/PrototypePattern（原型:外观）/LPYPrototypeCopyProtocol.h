//
//  LPYPrototypeCopyProtocol.h
//  LPYFramework
//
//  Created by admin on 16/1/26.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LPYPrototypeCopyProtocol <NSObject>

@required
/**
 *  克隆
 *
 *  @return 返回一个拷贝样本
 */
- (id)clone;

@end
