//
//  LPYCoinGamePadDecorator.h
//  LPYFramework
//
//  Created by admin on 16/1/27.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYGamePadDecorator.h"

// 增加投币按钮
@interface LPYCoinGamePadDecorator : LPYGamePadDecorator
/**
 *  游戏币
 */
@property (nonatomic, assign) NSInteger coin;
@end
