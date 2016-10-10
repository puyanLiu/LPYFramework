//
//  QQMHttpTool.m
//  NetworkingDemo
//
//  Created by liupuyan on 16/9/23.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "QQMHttpTool.h"
#import <AFNetworking.h>
#import "DeviceHelp.h"

@implementation QQMHttpTool

static QQMHttpTool *instance = nil;

+ (QQMHttpTool *)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:nil] init];
    });
    return instance;
}

- (AFHTTPSessionManager *)sessionManager {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 设置请求体
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *codeString = @"\uFFFC";
    NSString *msg=[@"￼qqm-client" stringByReplacingOccurrencesOfString:codeString withString:@""];
    NSString *device = [[DeviceHelp getDevice] stringByReplacingOccurrencesOfString:codeString withString:@""];
    [manager.requestSerializer setValue:device forHTTPHeaderField:msg];
    
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.0;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    // AFN 支持https
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    [securityPolicy setValidatesDomainName:NO];
    [securityPolicy setAllowInvalidCertificates:YES];
    manager.securityPolicy = securityPolicy;
    
    return manager;
}

- (void)_postMethodWithBaseURL:(NSString *)baseUrl uri:(NSString *)uri params:(NSDictionary *)params successCallback:(REQUEST_CALLBACK)callback failureCallback:(REQUEST_CALLBACK)failureCallback {
    AFHTTPSessionManager *manger = [self sessionManager];
    NSString *urlPath = [baseUrl stringByAppendingPathComponent:uri];
    [manger POST:urlPath parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}



- (void)_getMethod {
    
}

@end

