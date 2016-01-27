//
//  LPYAppleFactory.m
//  LPYFramework
//
//  Created by admin on 16/1/27.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYAppleFactory.h"
#import "LPYiPhone.h"
#import "LPYiWatch.h"

@implementation LPYAppleFactory
- (LPYBasePhone *)createPhone {
    return [[LPYiPhone alloc] init];
}

- (LPYBaseWatch *)createWatch {
    return [[LPYiWatch alloc] init];
}
@end
