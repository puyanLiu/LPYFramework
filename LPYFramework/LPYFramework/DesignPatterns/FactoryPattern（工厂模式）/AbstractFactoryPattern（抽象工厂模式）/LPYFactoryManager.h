//
//  LPYFactoryManager.h
//  LPYFramework
//
//  Created by admin on 16/1/27.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPYBaseFactory.h"
#import "LPYAppleFactory.h"
#import "LPYGoogleFactory.h"

typedef enum : NSUInteger {
    kApple = 0x11,
    kGoogle
} EFactoryType;

@interface LPYFactoryManager : NSObject

/**
 *  获取工厂
 *
 *  @param factoryType 工厂类型
 *
 *  @return 创建出得工厂
 */
+ (LPYBaseFactory *)factoryWithBrand:(EFactoryType)factoryType;

@end
