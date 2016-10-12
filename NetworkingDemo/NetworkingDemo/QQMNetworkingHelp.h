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
#define QQMKeyWindow ([UIApplication sharedApplication].keyWindow ?: [[[UIApplication sharedApplication] delegate] window])

// 网络请求帮助类
@interface QQMNetworkingHelp : NSObject

/**
 检查网络状态
 
 @return <#return value description#>
 */
+ (BOOL)checkNetworkState;

/**
 检查当前网络是否wifi状态
 
 @return <#return value description#>
 */
+ (BOOL)checkNetworkWifiState;

/**
 post请求
 
 @param uri      uri
 @param params   参数
 @param callback 请求成功回调
 */
+ (void)executeUrl:(NSString *)uri params:(NSDictionary *)params callback:(REQUEST_CALLBACK)callback;

/**
 post请求
 
 @param uri      uri
 @param params   参数
 @param callback 请求成功回调
 @param failureCallback 请求失败回调
 */
+ (void)executeUrl:(NSString *)uri params:(NSDictionary *)params callback:(REQUEST_CALLBACK)callback failureCallback:(REQUEST_CALLBACK)failureCallback;

/**
 post请求 不显示加载中状态
 
 @param uri      uri
 @param params   参数
 @param callback 请求成功回调
 @param failureCallback 请求失败回调
 */
+ (void)executeNotShowLoadingUrl:(NSString *)uri params:(NSDictionary *)params callback:(REQUEST_CALLBACK)callback failureCallback:(REQUEST_CALLBACK)failureCallback;

/**
 post请求 public地址
 
 @param uri      uri
 @param params   参数
 @param callback 请求成功回调
 @param failureCallback 请求失败回调
 */
+ (void)executePublicUrl:(NSString *)uri params:(NSDictionary *)params callback:(REQUEST_CALLBACK)callback failureCallback:(REQUEST_CALLBACK)failureCallback;

/**
 post请求 public地址 不显示加载中状态
 
 @param uri      uri
 @param params   参数
 @param callback 请求成功回调
 @param failureCallback 请求失败回调
 */
+ (void)executeNotShowLoadingPublicUrl:(NSString *)uri params:(NSDictionary *)params callback:(REQUEST_CALLBACK)callback failureCallback:(REQUEST_CALLBACK)failureCallback;

/**
 get请求
 
 @param uri      uri
 @param params   参数
 @param callback 请求成功回调
 @param failureCallback 请求失败回调
 */
+ (void)getExecuteUrl:(NSString *)uri params:(NSDictionary *)params callback:(REQUEST_CALLBACK)callback failureCallback:(REQUEST_CALLBACK)failureCallback;

/**
 get请求 获取内容HTML
 
 @param uri      uri
 @param params   参数
 @param callback 请求成功回调
 @param failureCallback 请求失败回调
 */
+ (void)getHTMLExecutePublicUrl:(NSString *)uri params:(NSDictionary *)params callback:(REQUEST_CALLBACK)callback failureCallback:(REQUEST_CALLBACK)failureCallback;

@end
