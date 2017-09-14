//
//  RCTBridge+Moles.h
//  rn37demo
//
//  Created by liupuyan on 16/12/23.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "RCTBridge.h"

typedef void (^RCTJavaScriptCompleteBlock)(NSError *error);

@interface RCTBridge (Moles)

/**
 *  业务JS
 */
@property (nonatomic, strong) NSURL *secondaryBundleURL;

/**
 加载业务包
 */
- (void)loadSecondary;

- (void)enqueueApplicationScript:(NSData *)script
                             url:(NSURL *)url
                      onComplete:(RCTJavaScriptCompleteBlock)onComplete;
@end
