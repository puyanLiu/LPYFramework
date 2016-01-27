//
//  LPYGamePad+LPYCoin.m
//  LPYFramework
//
//  Created by admin on 16/1/27.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYGamePad+LPYCoin.h"
#import <objc/runtime.h>
#import <Foundation/Foundation.h>

@implementation LPYGamePad (LPYCoin)

// 动态给某一属性添加关联

//static const NSString *_coinStr = @"_coinStr";

//- (void)setCoin:(NSInteger)coin {
//    objc_setAssociatedObject(self, (__bridge const void *)(_coinStr), @(coin), OBJC_ASSOCIATION_ASSIGN);
//}
//
//- (NSInteger)coin {
//    NSNumber *number = objc_getAssociatedObject(self, (__bridge const void *)(_coinStr));
//    return [number integerValue];
//}


NSInteger _coin;

- (void)setCoin:(NSInteger)coin {
    _coin = coin;
}

- (NSInteger)coin {
    return _coin;
}

@end
