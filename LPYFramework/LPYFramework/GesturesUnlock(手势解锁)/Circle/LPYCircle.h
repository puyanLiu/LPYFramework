//
//  LPYCircle.h
//  LPYFramework
//
//  Created by admin on 16/1/18.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  单个圆的各种状态
 */
typedef enum {
    LPYCircleStateNormal = 1,
    LPYCircleStateSelected,
    LPYCircleStateError,
    LPYCircleStateLastOneSelected,
    LPYCircleStateLastOneError
} LPYCircleState;

// 单个圆的用途类型
typedef enum {
    LPYCircleTypeInfo = 1,
    LPYCircleTypeGesture
} LPYCircleType;

@interface LPYCircle : UIView

/**
 *  所处的状态
 */
@property (nonatomic, assign) LPYCircleState state;

/**
 *  类型
 */
@property (nonatomic, assign) LPYCircleType type;

/**
 *  是否有箭头 default is YES
 */
@property (nonatomic, assign) BOOL arrow;

/** 角度 */
@property (nonatomic,assign) CGFloat angle;

@end
