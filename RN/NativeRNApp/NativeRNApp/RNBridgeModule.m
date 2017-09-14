//
//  RNBridgeModule.m
//  CommunicationDemo
//
//  Created by admin on 16/8/26.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "RNBridgeModule.h"

@interface RNBridgeModule ()

@end

@implementation RNBridgeModule

RCT_EXPORT_MODULE(RNBridgeModule)

RCT_EXPORT_METHOD(RNBackOC:(NSDictionary *)dictionay) {
  // 返回原生界面
  dispatch_async(dispatch_get_main_queue(), ^{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RNBackOCNotification" object:dictionay[@"className"]];
  });
}


@end
