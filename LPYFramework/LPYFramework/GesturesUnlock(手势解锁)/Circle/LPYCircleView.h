//
//  LPYCircleView.h
//  LPYFramework
//
//  Created by admin on 16/1/18.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LPYCircleViewDelegate;

/**
 *  手势密码界面用途类型
 */
typedef enum {
    LPYCircleViewTypeSetting = 1, // 设置手势密码
    LPYCircleViewTypeLogin,       // 登陆手势密码
    LPYCircleViewTypeVerify       // 验证旧手势密码
} LPYCircleViewType;

@interface LPYCircleView : UIView
/**
 *  是否剪裁 default is YES
 */
@property (nonatomic, assign) BOOL clip;

/**
 *  是否有箭头 default is YES
 */
@property (nonatomic, assign) BOOL arrow;

/**
 *  解锁类型
 */
@property (nonatomic, assign) LPYCircleViewType type;

// 代理
@property (nonatomic, weak) id<LPYCircleViewDelegate> delegate;

// 初始化方法（设置view的相关类型、参数）
- (instancetype)initWithType:(LPYCircleViewType)type clip:(BOOL)clip arrow:(BOOL)arrow;
@end

@protocol LPYCircleViewDelegate <NSObject>

@optional
#pragma mark - 设置手势密码代理方法
/**
 *  连线个数少于4个时，通知代理
 *
 *  @param view    circleView
 *  @param type    type
 *  @param gesture 手势结果
 */
- (void)circleView:(LPYCircleView *)view type:(LPYCircleViewType)type connectCirclesLessThanNeedWithGesture:(NSString *)gesture;

/**
 *  连线个数多于或等于4个，获取到第一个手势密码时通知代理
 *
 *  @param view    circleView
 *  @param type    type
 *  @param gesture 第一个次保存的密码
 */
- (void)circleView:(LPYCircleView *)view type:(LPYCircleViewType)type didCompleteSetFirstGesture:(NSString *)gesture;

/**
 *  获取到第二个手势密码时通知代理
 *
 *  @param view    circleView
 *  @param type    type
 *  @param gesture 第二次手势密码
 *  @param equal   第二次和第一次获得的手势密码匹配结果
 */
- (void)circleView:(LPYCircleView *)view type:(LPYCircleViewType)type didCompleteSetSecondGesture:(NSString *)gesture result:(BOOL)equal;

#pragma mark - 登录手势密码代理方法
/**
 *  登陆或者验证手势密码输入完成时的代理方法
 *
 *  @param view    circleView
 *  @param type    type
 *  @param gesture 登陆时的手势密码
 */
- (void)circleView:(LPYCircleView *)view type:(LPYCircleViewType)type didCompleteLoginGesture:(NSString *)gesture result:(BOOL)equal;

@end