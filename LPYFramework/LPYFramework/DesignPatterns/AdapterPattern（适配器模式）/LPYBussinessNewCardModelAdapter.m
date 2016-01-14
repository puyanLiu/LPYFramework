//
//  LPYBussinessNewCardModelAdapter.m
//  LPYFramework
//
//  Created by admin on 16/1/14.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYBussinessNewCardModelAdapter.h"
#import "LPYBussinessNewCardModel.h"

@implementation LPYBussinessNewCardModelAdapter
- (NSString *)name {
    return [self.data name];
}

- (UIColor *)lineColor {
    LPYBussinessNewCardModel *model = self.data;
    // TODO
    return [model.colorHexString isEqualToString:@"black"] ? [UIColor blackColor] : [UIColor greenColor];
}

- (NSString *)phoneNumber {
    return [self.data phoneNumber];
}
@end
