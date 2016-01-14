//
//  LPYBussinessCardAdapter.m
//  LPYFramework
//
//  Created by admin on 16/1/14.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYBussinessCardAdapter.h"
#import "LPYBussinessCardModel.h"
#import "LPYBussinessNewCardModel.h"

@implementation LPYBussinessCardAdapter

- (NSString *)name {
    NSString *name = nil;
    if ([self.data isMemberOfClass:[LPYBussinessCardModel class]]) {
        name = [self.data name];
    } else if ([self.data isMemberOfClass:[LPYBussinessNewCardModel class]]) {
        name = [self.data name];
    }
    return name;
}

- (UIColor *)lineColor {
    UIColor *color = nil;
    if ([self.data isMemberOfClass:[LPYBussinessCardModel class]]) {
        color = [self.data lineColor];
    } else if ([self.data isMemberOfClass:[LPYBussinessNewCardModel class]]) {
        color = [[self.data colorHexString] isEqualToString:@"black"] ? [UIColor blackColor] : [UIColor redColor];
    }
    return color;
}

- (NSString *)phoneNumber {
    NSString *phoneNumber = nil;
    if ([self.data isMemberOfClass:[LPYBussinessCardModel class]]) {
        phoneNumber = [self.data phoneNumber];
    } else if ([self.data isMemberOfClass:[LPYBussinessNewCardModel class]]) {
        phoneNumber = [self.data phoneNumber];
    }
    return phoneNumber;
}
@end
