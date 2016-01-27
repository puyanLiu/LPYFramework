//
//  LPYGamePadDecorator.m
//  LPYFramework
//
//  Created by admin on 16/1/27.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYGamePadDecorator.h"
#import "LPYGamePad.h"

@interface LPYGamePadDecorator ()
/**
 *  gamePad
 */
@property (nonatomic, strong) LPYGamePad *gamePad;
@end

@implementation LPYGamePadDecorator

- (instancetype)init {
    self = [super init];
    if (self) {
        self.gamePad = [[LPYGamePad alloc] init];
    }
    return self;
}

/**
 *  上下左右的操作
 */
- (void)up {
    [self.gamePad up];
}
- (void)down {
    [self.gamePad down];
}
- (void)left {
    [self.gamePad left];
}
- (void)right {
    [self.gamePad right];
}

/**
 *  选择与开始的操作
 */
- (void)select {
    [self.gamePad select];
}
- (void)start {
    [self.gamePad start];
}

/**
 *  按钮 A + B + X + Y
 */
- (void)commandA {
    [self.gamePad commandA];
}
- (void)commandB {
    [self.gamePad commandB];
}
- (void)commandX {
    [self.gamePad commandX];
}
- (void)commandY {
    [self.gamePad commandY];
}

@end
