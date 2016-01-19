//
//  LPYLockLabel.h
//  LPYFramework
//
//  Created by admin on 16/1/18.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPYLockLabel : UILabel
/**
 *  普通提示信息
 *
 *  @param msg 提示信息
 */
- (void)showNormalMsg:(NSString *)msg;

/**
 *  警示信息
 *
 *  @param msg 提示信息
 */
- (void)showWarnMsg:(NSString *)msg;

/**
 *  警示信息（shake）
 *
 *  @param msg 提示信息
 */
- (void)showWarnMsgAndShake:(NSString *)msg;
@end
