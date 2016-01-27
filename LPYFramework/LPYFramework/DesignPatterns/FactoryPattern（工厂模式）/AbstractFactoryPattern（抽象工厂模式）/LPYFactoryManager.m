//
//  LPYFactoryManager.m
//  LPYFramework
//
//  Created by admin on 16/1/27.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYFactoryManager.h"

@implementation LPYFactoryManager

+ (LPYBaseFactory *)factoryWithBrand:(EFactoryType)factoryType {
    LPYBaseFactory *factory = nil;
    
    if (factoryType == kApple) {
        factory = [[LPYAppleFactory alloc] init];
    } else if (factoryType == kGoogle) {
        factory = [[LPYGoogleFactory alloc] init];
    }
    
    return factory;
}

@end
