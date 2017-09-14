//
//  ReactViewController.m
//  rn37demo
//
//  Created by liupuyan on 16/12/23.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "ReactViewController.h"
#import "RCTBridge.h"
#import "RCTBridge+Moles.h"
#import "RCTRootView+Moles.h"

static RCTBridge *commonBridge = NULL;

@interface ReactViewController ()

@end

@implementation ReactViewController

+ (NSString *)moduleName {
    return @"MOLES";
}

+ (NSURL *)commonJSURL {
    return [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"./build/moles.common/common.ios" ofType:@"jsbundle"]];
}

/**
 加载内置公共JS，并且在初始化加载业务JS，Bridge独立

 @param bundleURL 业务JSbundle
 @param initialProperties <#initialProperties description#>
 @param launchOptions <#launchOptions description#>
 @return <#return value description#>
 */
- (instancetype)initWithBundleURL:(NSURL *)bundleURL initialProperties:(NSDictionary *)initialProperties launchOptions:(NSDictionary *)launchOptions {
    if (self = [super init]) {
        // 加载公共包
        RCTRootView *rootView = [[RCTRootView alloc] initWithPrimaryURL:[[self class] commonJSURL] secondaryURL:bundleURL moduleName:[[self class] moduleName] initialProperties:initialProperties launchOptions:launchOptions];
        self.view = rootView;
        // 发送通知，等待JavaScript加载完成开始加载业务包
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadBusinessBundle) name:RCTJavaScriptDidLoadNotification object:nil];
    }
    return self;
}

/**
 加载内置公共JS，允许设置是否使用公共Bridge
 需要在页面显示时自己掉 -(void)loadBusinessBundle 来加载业务JS

 @param bundleURL 业务JSbundle
 @param initialProperties <#initialProperties description#>
 @param launchOptions <#launchOptions description#>
 @param useCommonBridge <#useCommonBridge description#>
 @return <#return value description#>
 */
- (instancetype)initWithBundleURL:(NSURL *)bundleURL initialProperties:(NSDictionary *)initialProperties launchOptions:(NSDictionary *)launchOptions useCommonBridge:(BOOL)useCommonBridge {
    if (!useCommonBridge) {
        return [self initWithBundleURL:bundleURL initialProperties:initialProperties launchOptions:launchOptions];
    }
    if (self = [super init]) {
      RCTRootView *rootView;
      if (!commonBridge) {
          rootView = [[RCTRootView alloc] initWithBundleURL:[[self class] commonJSURL] moduleName:[[self class] moduleName] initialProperties:initialProperties launchOptions:launchOptions];
          commonBridge = rootView.bridge;
      } else {
          rootView = [[RCTRootView alloc] initWithBridge:commonBridge moduleName:[[self class] moduleName] initialProperties:initialProperties];
      }
      rootView.bridge.secondaryBundleURL = bundleURL;
      self.view = rootView;
    }
    return self;
}


- (void)loadBusinessBundle {
    RCTBridge *bridge = [(RCTRootView *)self.view bridge];
    [bridge loadSecondary];
}

- (RCTRootView *)rootView {
    return (RCTRootView *)self.view;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
