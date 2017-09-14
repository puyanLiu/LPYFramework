//
//  RCTRootView+Moles.h
//  rn37demo
//
//  Created by liupuyan on 16/12/23.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "RCTRootView.h"

@interface RCTRootView (Moles)

/**
 初始化RCTRootView
 
 @param primaryURL 公共包URL
 @param secondaryURL 业务包URL
 @param moduleName 模块名，registerComponent第一个参数名 AppRegistry.registerComponent('ReactExample', () => ReactExample);
 @param initialProperties 此字典参数会在内部被转化为一个可供JS组件调用的JSON对象
 @param launchOptions 应用程序启动时传递的参数
 @return RCTBridge实例
 */
- (instancetype)initWithPrimaryURL:(NSURL *)primaryURL secondaryURL:(NSURL *)secondaryURL moduleName:(NSString *)moduleName initialProperties:(NSDictionary *)initialProperties launchOptions:(NSDictionary *)launchOptions;

@end
