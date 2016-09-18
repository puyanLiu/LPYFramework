//
//  LPYADView.h
//  LPYFramework
//
//  Created by liupuyan on 16/9/18.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define UserDefaults [NSUserDefaults standardUserDefaults]

static NSString *const adImageName = @"adImageName";
static NSString *const adUrl = @"adUrl";

@interface LPYADView : UIView
/**
 *  倒计时（默认3秒）
 */
@property (nonatomic, assign) NSUInteger showTime;

/**
 *  初始化方法
 *
 *  @param frame    <#frame description#>
 *  @param imageUrl <#imageUrl description#>
 *  @param adUrl    <#adUrl description#>
 *  @param block    <#block description#>
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithFrame:(CGRect)frame imgUrl:(NSString *)imageUrl adUrl:(NSString *)adUrl clickImgBlock:(void(^)(NSString *clickImgUrl))block;

/**
 *  显示广告页面
 */
- (void)show;
@end
