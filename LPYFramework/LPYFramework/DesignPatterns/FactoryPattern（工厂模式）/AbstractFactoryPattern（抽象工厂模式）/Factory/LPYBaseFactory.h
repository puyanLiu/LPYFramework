//
//  LPYBaseFactory.h
//  LPYFramework
//
//  Created by admin on 16/1/27.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPYBasePhone.h"
#import "LPYBaseWatch.h"

@interface LPYBaseFactory : NSObject

/**
 *  创建手机
 *
 *  @return 手机
 */
- (LPYBasePhone *)createPhone;

/**
 *  创建手表
 *
 *  @return 手表
 */
- (LPYBaseWatch *)createWatch;
@end
