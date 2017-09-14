//
//  LPYMapManager.m
//  MapViewDemo
//
//  Created by liupuyan on 16/9/9.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "LPYMapManager.h"
#import <MapKit/MapKit.h>
#import "RCTMap.h"

@implementation LPYMapManager

RCT_EXPORT_MODULE()

- (UIView *)view {
  return [[MKMapView alloc] init];
}

// 封装原生属性给JS使用
// RN用RCTConvert来在JS和原生代码之间完成类型转换
// 手指捏放操作
RCT_EXPORT_VIEW_PROPERTY(pitchEnabled, BOOL)

@end
