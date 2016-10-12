//
//  NetworkingHelp.m
//  QQMProject
//
//  Created by admin on 15/10/23.
//  Copyright © 2015年 admin. All rights reserved.
//

#import "QQMNetworkingHelp.h"
#import <AFNetworking.h>
#import "MBProgressHUD+Extension.h"
#import "URLHelp.h"
#import "DeviceHelp.h"

/*
 网络状态不佳提示用户“网络不给力”
 API异常提示用户“网络错误，请您稍后刷新试试”
 */
@implementation QQMNetworkingHelp

static QQMNetworkingHelp *instance = nil;
static dispatch_once_t onceToken;

+ (QQMNetworkingHelp *)shareInstance
{
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[super allocWithZone:nil] init];
        }
    });
    return instance;
}

#pragma mark - 外部方法
/**
 检查网络状态
 
 @return <#return value description#>
 */
+ (BOOL)checkNetworkState {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

/**
 检查当前网络是否wifi状态
 
 @return <#return value description#>
 */
+ (BOOL)checkNetworkWifiState {
    return [AFNetworkReachabilityManager sharedManager].reachableViaWiFi;
}

/**
 post请求
 
 @param uri      uri
 @param params   参数
 @param callback 请求成功回调
 */
+ (void)executeUrl:(NSString *)uri params:(NSDictionary *)params callback:(REQUEST_CALLBACK)callback {
    [self executeUrl:uri params:params callback:callback failureCallback:nil];
}

/**
 post请求
 
 @param uri      uri
 @param params   参数
 @param callback 请求成功回调
 @param failureCallback 请求失败回调
 */
+ (void)executeUrl:(NSString *)uri params:(NSDictionary *)params callback:(REQUEST_CALLBACK)callback failureCallback:(REQUEST_CALLBACK)failureCallback {
    QQMNetworkingHelp *netWorking = [self shareInstance];
    NSString *urlPath = [[URLHelp shareUrlHelp].rootURL stringByAppendingPathComponent:uri];
    NSLog(@"%@", urlPath);
    [netWorking _executeURL:urlPath params:params callback:callback failureCallback:failureCallback isLoading:YES];
}

/**
 post请求 不显示加载中状态
 
 @param uri      uri
 @param params   参数
 @param callback 请求成功回调
 @param failureCallback 请求失败回调
 */
+ (void)executeNotShowLoadingUrl:(NSString *)uri params:(NSDictionary *)params callback:(REQUEST_CALLBACK)callback failureCallback:(REQUEST_CALLBACK)failureCallback {
    QQMNetworkingHelp *netWorking = [self shareInstance];
    NSString *urlPath = [[URLHelp shareUrlHelp].rootURL stringByAppendingPathComponent:uri];
    NSLog(@"%@", urlPath);
    [netWorking _executeURL:urlPath params:params callback:callback failureCallback:failureCallback isLoading:NO];
}

/**
 post请求 public地址
 
 @param uri      uri
 @param params   参数
 @param callback 请求成功回调
 @param failureCallback 请求失败回调
 */
+ (void)executePublicUrl:(NSString *)uri params:(NSDictionary *)params callback:(REQUEST_CALLBACK)callback failureCallback:(REQUEST_CALLBACK)failureCallback {
    QQMNetworkingHelp *netWorking = [self shareInstance];
    NSString *urlPath = [[URLHelp shareUrlHelp].publicURL stringByAppendingPathComponent:uri];
    NSLog(@"%@", urlPath);
    [netWorking _executeURL:urlPath params:params callback:callback failureCallback:failureCallback isLoading:YES];
}

/**
 post请求 public地址
 
 @param uri      uri
 @param params   参数
 @param callback 请求成功回调
 @param failureCallback 请求失败回调
 */
+ (void)executeNotShowLoadingPublicUrl:(NSString *)uri params:(NSDictionary *)params callback:(REQUEST_CALLBACK)callback failureCallback:(REQUEST_CALLBACK)failureCallback {
    QQMNetworkingHelp *netWorking = [self shareInstance];
    NSString *urlPath = [[URLHelp shareUrlHelp].publicURL stringByAppendingPathComponent:uri];
    NSLog(@"%@", urlPath);
    [netWorking _executeURL:urlPath params:params callback:callback failureCallback:failureCallback isLoading:NO];
}

/**
 get请求
 
 @param uri      uri
 @param params   参数
 @param callback 请求成功回调
 @param failureCallback 请求失败回调
 */
+ (void)getExecuteUrl:(NSString *)uri params:(NSDictionary *)params callback:(REQUEST_CALLBACK)callback failureCallback:(REQUEST_CALLBACK)failureCallback {
    QQMNetworkingHelp *netWorking = [self shareInstance];
    NSString *urlPath = [[URLHelp shareUrlHelp].publicURL stringByAppendingPathComponent:uri];
    NSLog(@"%@", urlPath);
    [netWorking _getExecuteURL:urlPath params:params callback:callback failureCallback:failureCallback];
}

/**
 get请求 获取内容HTML
 
 @param uri      uri
 @param params   参数
 @param callback 请求成功回调
 @param failureCallback 请求失败回调
 */
+ (void)getHTMLExecutePublicUrl:(NSString *)uri params:(NSDictionary *)params callback:(REQUEST_CALLBACK)callback failureCallback:(REQUEST_CALLBACK)failureCallback {
    QQMNetworkingHelp *netWorking = [self shareInstance];
    NSString *urlPath = [@"http://192.168.1.123:8080/api/app/fast/" stringByAppendingPathComponent:uri];
    NSLog(@"%@", urlPath);
    [netWorking _getHTMLExecuteURL:urlPath params:params callback:callback failureCallback:failureCallback];
}

#pragma mark - 网络请求相关
- (void)_getHTMLExecuteURL:(NSString *)url params:(NSDictionary *)params callback:(REQUEST_CALLBACK)callback failureCallback:(REQUEST_CALLBACK)failureCallback {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    /*
     Error Domain=NSCocoaErrorDomain Code=3840 "The operation couldn’t be completed. (Cocoa error 3840.)" (JSON text did not start with array or object and option to allow fragments not set.) UserInfo=0x9152780 {NSDebugDescription=JSON text did not start with array or object and option to allow fragments not set.}
     */
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 5;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html", @"text/plain", nil];
    
    // 网络状况检测
    [self beforeExecute:manager failureCallback:failureCallback];
    
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"get------------------------%@,-----------------%zd, -------------------------%zd", downloadProgress, downloadProgress.totalUnitCount, downloadProgress.completedUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QQMResponse *response = [[QQMResponse alloc] init];
        NSHTTPURLResponse *httpUrlResponse = (NSHTTPURLResponse *)task.response;
        response.header = [httpUrlResponse allHeaderFields];
        response.htmlContent = responseObject;
        
        if (![self afterExecute:response]) {
            if (failureCallback) {
                failureCallback(response);
            }
            return;
        }
        if (![self showInfo:response failureCallback:failureCallback]) {
            return;
        }
        if(callback != nil)
        {
            callback(response);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        QQMResponse *response = [[QQMResponse alloc] init];
        
        response.error = error;
        response.status = @(-1);
        
        if (![self afterExecute:response]) {
            if (failureCallback) {
                failureCallback(response);
            }
            return;
        }
        if (![self showInfo:response failureCallback:failureCallback]) {
            return;
        }
        if (callback != nil) {
            callback(response);
        }
    }];
}

- (void)_getExecuteURL:(NSString *)url params:(NSDictionary *)params callback:(REQUEST_CALLBACK)callback failureCallback:(REQUEST_CALLBACK)failureCallback {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 5;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    // 网络状况检测
    [self beforeExecute:manager failureCallback:failureCallback];
    
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"get------------------------%@,-----------------%zd, -------------------------%zd", downloadProgress, downloadProgress.totalUnitCount, downloadProgress.completedUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QQMResponse *response = [[QQMResponse alloc] init];
        NSHTTPURLResponse *httpUrlResponse = (NSHTTPURLResponse *)task.response;
        response.header = [httpUrlResponse allHeaderFields];
        response.textDictionary = responseObject;
        response.status = [responseObject objectForKey:@"status"];
        response.statusDes = [responseObject objectForKey:@"des"];
        
        if (![self afterExecute:response]) {
            if (failureCallback) {
                failureCallback(response);
            }
            return;
        }
        if (![self showInfo:response failureCallback:failureCallback]) {
            return;
        }
        if(callback != nil)
        {
            callback(response);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        QQMResponse *response = [[QQMResponse alloc] init];
        response.error = error;
        response.status = @(-1);
        
        if (![self afterExecute:response]) {
            if (failureCallback) {
                failureCallback(response);
            }
            return;
        }
        if (![self showInfo:response failureCallback:failureCallback]) {
            return;
        }
        if (callback != nil) {
            callback(response);
        }
    }];
}

- (void)_executeURL:(NSString *)url params:(NSDictionary *)params callback:(REQUEST_CALLBACK)callback failureCallback:(REQUEST_CALLBACK)failureCallback isLoading:(BOOL)isLoading{
    [MBProgressHUD hideHUDForView:QQMKeyWindow animated:YES];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    // 设置请求体
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
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:QQMKeyWindow animated:YES];
    hud.label.text = @"正在加载中";
    
    // 网络状况检测
    [self beforeExecute:manager failureCallback:failureCallback];
    
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"post------------------------%@,-----------------%zd, -------------------------%zd", uploadProgress, uploadProgress.totalUnitCount, uploadProgress.completedUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功");
        QQMResponse *response = [[QQMResponse alloc] init];
        NSHTTPURLResponse *httpUrlResponse = (NSHTTPURLResponse *)task.response;
        response.header = [httpUrlResponse allHeaderFields];
        response.textDictionary = responseObject;
        response.status = [responseObject objectForKey:@"status"];
        response.statusDes = [responseObject objectForKey:@"des"];
        
        [MBProgressHUD hideHUDForView:QQMKeyWindow animated:YES];
        
        if (![self afterExecute:response]) {
            if (failureCallback) {
                failureCallback(response);
            }
            return;
        }
        if (![self showInfo:response failureCallback:failureCallback]) {
            return;
        }
        if(callback != nil)
        {
            callback(response);
        }
        NSLog(@"加载成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
        QQMResponse *response = [[QQMResponse alloc] init];
        response.error = error;
        response.status = @(-1);
        
        [MBProgressHUD hideHUDForView:QQMKeyWindow animated:YES];
        
        if (![self afterExecute:response]) {
            if (failureCallback) {
                failureCallback(response);
            }
            return;
        }
        if (![self showInfo:response failureCallback:failureCallback]) {
            return;
        }
        if (callback != nil) {
            callback(response);
        }
    }];
}

#pragma mark - 内部方法
/*
 700100 申请授信
 -401 未填写认证信息(跳转至个人资料认证)
 -402 未绑定银行卡(跳转至绑定银行卡)
 -403 未设置支付密码(跳转至设置支付密码)
 -404 有现金账单未还清或审核中(跳转至账单)
 -405 未绑定银行卡和未设置支付密码
 -406 支付密码错误(跳转至重置密码)
 -407 强制登出
 -410 密码锁定
 -111 跳转认证信息页面
 -110 跳转到银行卡
 -106 提现功能关闭
 -113 跳转至提升额度界面
 */
- (BOOL)showInfo:(QQMResponse *)response failureCallback:(REQUEST_CALLBACK)failureCallback{
    NSLog(@"服务器返回数据===%@", response);
    // 远程调用服务类，判断字符串是否为nil，用如下方法[response.statusDes isKindOfClass:[NSNull class]]
    if(![response.statusDes isKindOfClass:[NSNull class]] && response.statusDes.length > 0)
    {
        if (failureCallback) {
            failureCallback(response);
        }
        [self errorInfo:response.statusDes];
        return false;
    }
    return true;
}

/**
 错误弹框
 
 @param error <#error description#>
 */
- (void)errorInfo:(NSString *)error {
    // 出现错误，全部隐藏
    [MBProgressHUD hideHUDForView:QQMKeyWindow animated:NO];
    [MBProgressHUD showError:error];
}

/**
 网络请求前检查
 
 @param response <#response description#>
 
 @return <#return value description#>
 */
- (BOOL)afterExecute:(QQMResponse *) response {
    
    if (response.error == nil) {
        return true;
    }
    
    // 网络未连接
    if ([response.error code] == NSURLErrorNotConnectedToInternet) {
        [self errorInfo:@"网络异常，请检查您的网络连接"];
        return false;
    }
    // 服务器故障
    NSLog(@"server error text is %@", response.error);
    [self errorInfo:@"服务器错误，请您稍后刷新试试"];
    return false;
}

/**
 判断网络状态
 注：检查网络状态和顺序执行的请求没有在一个线程里，因此通过队列来控制。当网络状态不可用的时候，会发出通知，说执行的请求被立刻中断执行，回到failure
 
 @param manager <#manager description#>
 
 @return <#return value description#>
 */
- (BOOL)beforeExecute:(AFHTTPSessionManager*)manager failureCallback:(REQUEST_CALLBACK)failureCallback {
    NSOperationQueue *operationQueue = manager.operationQueue;
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];
                break;
            case AFNetworkReachabilityStatusNotReachable:
            default:
            {
                if (failureCallback) {
                    failureCallback(nil);
                }
                [MBProgressHUD hideHUDForView:QQMKeyWindow animated:YES];
                [self errorInfo:@"网络异常，请检查您的网络连接"];
                [operationQueue setSuspended:YES];
            }
                break;
        }
    }];
    [manager.reachabilityManager startMonitoring];
    return true;
}
@end
