//
//  LPYBussinessCardAdapter.m
//  LPYFramework
//
//  Created by admin on 16/1/14.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYBussinessBaseCardAdapter.h"

@implementation LPYBussinessBaseCardAdapter

- (instancetype)initWithData:(id)data {
    self = [super init];
    if (self) {
        self.data = data;
    }
    
    return self;
}

- (NSString *)name {
    return nil;
}

- (UIColor *)lineColor {
    return nil;
}

- (NSString *)phoneNumber {
    return nil;
}
@end
