//
//  LPYGoogleFactory.m
//  LPYFramework
//
//  Created by admin on 16/1/27.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYGoogleFactory.h"
#import "LPYAndroid.h"
#import "LPYAndroidWatch.h"

@implementation LPYGoogleFactory
- (LPYBasePhone *)createPhone {
    return [[LPYAndroid alloc] init];
}

- (LPYBaseWatch *)createWatch {
    return [[LPYAndroidWatch alloc] init];
}
@end
