//
//  ReactViewController.h
//  rn37demo
//
//  Created by liupuyan on 16/12/23.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCTRootView.h"

@interface ReactViewController : UIViewController

/**
 加载内置公共JS，并且在初始化加载业务JS，Bridge独立
 
 @param bundleURL 业务JSbundle
 @param initialProperties <#initialProperties description#>
 @param launchOptions <#launchOptions description#>
 @return <#return value description#>
 */
- (instancetype)initWithBundleURL:(NSURL *)bundleURL initialProperties:(NSDictionary *)initialProperties launchOptions:(NSDictionary *)launchOptions;

/**
 加载内置公共JS，允许设置是否使用公共Bridge
 需要在页面显示时自己掉 -(void)loadBusinessBundle 来加载业务JS
 
 @param bundleURL 业务JSbundle
 @param initialProperties <#initialProperties description#>
 @param launchOptions <#launchOptions description#>
 @param useCommonBridge <#useCommonBridge description#>
 @return <#return value description#>
 */
- (instancetype)initWithBundleURL:(NSURL *)bundleURL initialProperties:(NSDictionary *)initialProperties launchOptions:(NSDictionary *)launchOptions useCommonBridge:(BOOL)useCommonBridge;

- (RCTRootView *)rootView;

- (void)loadBusinessBundle;

@end
