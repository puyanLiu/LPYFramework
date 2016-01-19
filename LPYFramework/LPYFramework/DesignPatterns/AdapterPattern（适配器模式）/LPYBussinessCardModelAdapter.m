//
//  LPYBussinessCardModelAdapter.m
//  LPYFramework
//
//  Created by admin on 16/1/14.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYBussinessCardModelAdapter.h"

@implementation LPYBussinessCardModelAdapter
- (NSString *)name {
    return [self.data name];
}

- (UIColor *)lineColor {
    return [self.data lineColor];
}

- (NSString *)phoneNumber {
    return [self.data phoneNumber];
}
@end
