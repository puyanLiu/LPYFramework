//
//  LPYLockLabel.m
//  LPYFramework
//
//  Created by admin on 16/1/18.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYLockLabel.h"
#import "LPYCircleViewConst.h"
#import "CALayer+LPYAnimation.h"

@implementation LPYLockLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [self setFont:[UIFont systemFontOfSize:14.0f]];
    [self setTextAlignment:NSTextAlignmentCenter];
}

/**
 *  普通提示信息
 *
 *  @param msg 提示信息
 */
- (void)showNormalMsg:(NSString *)msg {
    [self setText:msg];
    [self setTextColor:textColorNormalState];
}

/**
 *  警示信息
 *
 *  @param msg 提示信息
 */
- (void)showWarnMsg:(NSString *)msg {
    [self setText:msg];
    [self setTextColor:textColorWarningState];
}

/**
 *  警示信息（shake）
 *
 *  @param msg 提示信息
 */
- (void)showWarnMsgAndShake:(NSString *)msg {
    [self setText:msg];
    [self setTextColor:textColorWarningState];
    
    // 添加摇动动画
    [self.layer shake];
}
@end
