//
//  LPYDeviceFactory.h
//  LPYFramework
//
//  Created by admin on 16/1/27.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPYBaseDevice.h"
#import "LPYiPhoneDevice.h"
#import "LPYAndroidDevice.h"
#import "LPYNokiaDevice.h"

typedef enum : NSUInteger {
    kiPhone = 0x11,
    kAndroid,
    kNokia
} EDeviceType;

@interface LPYDeviceFactory : NSObject

/**
 *  根据用户指定的指令创建出具体的手机
 *
 *  @param type 创建的指令
 *
 *  @return 创建出的手机
 */
+ (LPYBaseDevice<LPYPhoneProtocol> *)deviceFactoryWithDeviceType:(EDeviceType)type;

@end
