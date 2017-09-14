//
//  CustomBridgeManager.m
//  queqianmeShanghuReact
//
//  Created by laowen on 16/8/24.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "CustomBridgeManager.h"
#import "RCTConvert.h"
#import "RCTBridge.h"
#import "RCTEventDispatcher.h"

@implementation CustomBridgeManager
@synthesize bridge=_bridge;

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(gotoSystemSetupCenter){
  NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
  if ([[UIApplication sharedApplication] canOpenURL:url]) {
    [[UIApplication sharedApplication] openURL:url];
  }
}

RCT_EXPORT_METHOD(deleteFileWithPath:(NSString *)path){
  if (path) {
    NSFileManager *manager = [[NSFileManager alloc]init];
    BOOL isIn = [manager fileExistsAtPath:path]; // 存在否
    BOOL isCanDel = [manager isDeletableFileAtPath:path]; // 可删否
    if (isIn && isCanDel) {
      [manager removeItemAtPath:path error:nil];
    }
  }
  
}

@end
