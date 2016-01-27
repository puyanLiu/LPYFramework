//
//  LPYDeviceFactory.m
//  LPYFramework
//
//  Created by admin on 16/1/27.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYDeviceFactory.h"

@implementation LPYDeviceFactory

+ (LPYBaseDevice<LPYPhoneProtocol> *)deviceFactoryWithDeviceType:(EDeviceType)type {
    LPYBaseDevice<LPYPhoneProtocol> *device = nil;
    
    if (type == kiPhone) {
        device = [[LPYiPhoneDevice alloc] init];
    } else if (type == kAndroid) {
        device = [[LPYAndroidDevice alloc] init];
    } else if (type == kNokia) {
        device = [[LPYNokiaDevice alloc] init];
    }
    
    return device;
}

@end
