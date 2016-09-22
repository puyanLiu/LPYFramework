//
//  NetworkingHelp.h
//  QQMProject
//
//  Created by admin on 15/10/23.
//  Copyright © 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QQMResponse.h"

#define REQUEST_CALLBACK void (^)(QQMResponse *response)

typedef enum {
    Method_POST,
    Method_Get
} Method;

typedef enum {
    ShowMessageMethod_ALERT,
    ShowMessageMethod_HUD
} ShowMessageMethod;

// 网络请求帮助类
@interface QQMNetworkingHelp : NSObject

@end
