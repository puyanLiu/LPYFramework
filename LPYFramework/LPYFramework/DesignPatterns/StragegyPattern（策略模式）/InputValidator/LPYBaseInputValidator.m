//
//  LPYBaseInputValidator.m
//  LPYFramework
//
//  Created by admin on 16/1/15.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYBaseInputValidator.h"

@implementation LPYBaseInputValidator

// 抽象的实现
- (BOOL)validateInput:(UITextField *)input {
    return NO;
}

@end
