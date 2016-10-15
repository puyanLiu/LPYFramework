// AFNetworkReachabilityManager.m

#import "AFNetworkReachabilityManager.h"
#if !TARGET_OS_WATCH

#import <netinet/in.h>
#import <netinet6/in6.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#import <netdb.h>

NSString * const AFNetworkingReachabilityDidChangeNotification = @"com.alamofire.networking.reachability.change";
NSString * const AFNetworkingReachabilityNotificationStatusItem = @"AFNetworkingReachabilityNotificationStatusItem";

typedef void (^AFNetworkReachabilityStatusBlock)(AFNetworkReachabilityStatus status);

NSString * AFStringFromNetworkReachabilityStatus(AFNetworkReachabilityStatus status) {
    switch (status) {
        case AFNetworkReachabilityStatusNotReachable:
            return NSLocalizedStringFromTable(@"Not Reachable", @"AFNetworking", nil);
        case AFNetworkReachabilityStatusReachableViaWWAN:
            return NSLocalizedStringFromTable(@"Reachable via WWAN", @"AFNetworking", nil);
        case AFNetworkReachabilityStatusReachableViaWiFi:
            return NSLocalizedStringFromTable(@"Reachable via WiFi", @"AFNetworking", nil);
        case AFNetworkReachabilityStatusUnknown:
        default:
            return NSLocalizedStringFromTable(@"Unknown", @"AFNetworking", nil);
    }
}


/**
 网络状态标志位
 typedef CF_OPTIONS(uint32_t, SCNetworkReachabilityFlags) {
	kSCNetworkReachabilityFlagsTransientConnection	= 1<<0,
	kSCNetworkReachabilityFlagsReachable		= 1<<1,
	kSCNetworkReachabilityFlagsConnectionRequired	= 1<<2,
	kSCNetworkReachabilityFlagsConnectionOnTraffic	= 1<<3,
	kSCNetworkReachabilityFlagsInterventionRequired	= 1<<4,
	kSCNetworkReachabilityFlagsConnectionOnDemand	= 1<<5,	// __OSX_AVAILABLE_STARTING(__MAC_10_6,__IPHONE_3_0)
	kSCNetworkReachabilityFlagsIsLocalAddress	= 1<<16,
	kSCNetworkReachabilityFlagsIsDirect		= 1<<17,
 #if	TARGET_OS_IPHONE
	kSCNetworkReachabilityFlagsIsWWAN		= 1<<18,
 #endif	// TARGET_OS_IPHONE
 
	kSCNetworkReachabilityFlagsConnectionAutomatic	= kSCNetworkReachabilityFlagsConnectionOnTraffic
 };

 @param flags 是一个SCNetworkReachabilityFlags，它的不同位代表了不同的网络可达性状态，通过flags的位操作，获取当前的状态信息AFNetworkReachabilityStatus

 @return <#return value description#>
 */
static AFNetworkReachabilityStatus AFNetworkReachabilityStatusForFlags(SCNetworkReachabilityFlags flags) {
    BOOL isReachable = ((flags & kSCNetworkReachabilityFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkReachabilityFlagsConnectionRequired) != 0);
    BOOL canConnectionAutomatically = (((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) || ((flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0));
    BOOL canConnectWithoutUserInteraction = (canConnectionAutomatically && (flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0);
    BOOL isNetworkReachable = (isReachable && (!needsConnection || canConnectWithoutUserInteraction));

    AFNetworkReachabilityStatus status = AFNetworkReachabilityStatusUnknown;
    if (isNetworkReachable == NO) {
        status = AFNetworkReachabilityStatusNotReachable;
    }
#if	TARGET_OS_IPHONE
    else if ((flags & kSCNetworkReachabilityFlagsIsWWAN) != 0) {
        status = AFNetworkReachabilityStatusReachableViaWWAN;
    }
#endif
    else {
        status = AFNetworkReachabilityStatusReachableViaWiFi;
    }

    return status;
}

/**
 * Queue a status change notification for the main thread.
 *
 * This is done to ensure that the notifications are received in the same order
 * as they are sent. If notifications are sent directly, it is possible that
 * a queued notification (for an earlier status condition) is processed after
 * the later update, resulting in the listener being left in the wrong state.
 */
static void AFPostReachabilityStatusChange(SCNetworkReachabilityFlags flags, AFNetworkReachabilityStatusBlock block) {
    // 调用AFNetworkReachabilityStatusForFlags获取当前的网络可达性状态
    AFNetworkReachabilityStatus status = AFNetworkReachabilityStatusForFlags(flags);
    // 在主线程中异步执行传入的callback
    dispatch_async(dispatch_get_main_queue(), ^{
        if (block) {
            block(status);
        }
        // 发出通知
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
        // 传入通知的数据
        NSDictionary *userInfo = @{ AFNetworkingReachabilityNotificationStatusItem: @(status) };
        [notificationCenter postNotificationName:AFNetworkingReachabilityDidChangeNotification object:nil userInfo:userInfo];
    });
}


/**
 在Main Runloop中对网络状态进行监控之后，在每次网络状态改变，就会调用AFNetworkReachabilityCallback函数

 @param target <#target description#>
 @param flags  <#flags description#>
 @param info   <#info description#>
 */
static void AFNetworkReachabilityCallback(SCNetworkReachabilityRef __unused target, SCNetworkReachabilityFlags flags, void *info) {
    // 这里从info中取出之前存在context中的AFNetworkReachabilityStatusBlock
    AFPostReachabilityStatusChange(flags, (__bridge AFNetworkReachabilityStatusBlock)info);
}

static const void * AFNetworkReachabilityRetainCallback(const void *info) {
    
    return (__typeof(info))_Block_copy((const void *)(info));
}

static void AFNetworkReachabilityReleaseCallback(const void *info) {
    if (info) {
        _Block_release((const void *)(info));
    }
}

@interface AFNetworkReachabilityManager ()
@property (readonly, nonatomic, assign) SCNetworkReachabilityRef networkReachability;
@property (readwrite, nonatomic, assign) AFNetworkReachabilityStatus networkReachabilityStatus;
@property (readwrite, nonatomic, copy) AFNetworkReachabilityStatusBlock networkReachabilityStatusBlock;
@end

@implementation AFNetworkReachabilityManager

+ (instancetype)sharedManager {
    static AFNetworkReachabilityManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [self manager];
    });

    return _sharedManager;
}

+ (instancetype)managerForDomain:(NSString *)domain {
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(kCFAllocatorDefault, [domain UTF8String]);

    AFNetworkReachabilityManager *manager = [[self alloc] initWithReachability:reachability];
    
    CFRelease(reachability);

    return manager;
}


/**
 初始化网络状态

 @param address <#address description#>

 @return <#return value description#>
 */
+ (instancetype)managerForAddress:(const void *)address {
    // 使用SCNetworkReachabilityCreateWithAddress生成一个SCNetworkReachabilityRef引用
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr *)address);
    // 将生成的SCNetworkReachabilityRef引用传给AFNetworkReachabilityManager
    AFNetworkReachabilityManager *manager = [[self alloc] initWithReachability:reachability];

    // 释放reachability
    CFRelease(reachability);
    
    return manager;
}

+ (instancetype)manager
{
#if (defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && __IPHONE_OS_VERSION_MIN_REQUIRED >= 90000) || (defined(__MAC_OS_X_VERSION_MIN_REQUIRED) && __MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)
    struct sockaddr_in6 address;
    bzero(&address, sizeof(address));
    address.sin6_len = sizeof(address);
    address.sin6_family = AF_INET6;
#else
    struct sockaddr_in address;
    bzero(&address, sizeof(address));
    address.sin_len = sizeof(address);
    address.sin_family = AF_INET;
#endif
    return [self managerForAddress:&address];
}

- (instancetype)initWithReachability:(SCNetworkReachabilityRef)reachability {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    // 把reachability赋值给self.networkReachability，并将原来的reachability的引用计数器+1
    _networkReachability = CFRetain(reachability);
    // 设置一个默认的网络状态
    self.networkReachabilityStatus = AFNetworkReachabilityStatusUnknown;

    return self;
}

- (instancetype)init NS_UNAVAILABLE
{
    return nil;
}

- (void)dealloc {
    [self stopMonitoring];
    
    if (_networkReachability != NULL) {
        CFRelease(_networkReachability);
    }
}

#pragma mark -


/**
 网络可用

 @return <#return value description#>
 */
- (BOOL)isReachable {
    return [self isReachableViaWWAN] || [self isReachableViaWiFi];
}


/**
 手机网络

 @return <#return value description#>
 */
- (BOOL)isReachableViaWWAN {
    return self.networkReachabilityStatus == AFNetworkReachabilityStatusReachableViaWWAN;
}


/**
 WiFi状态

 @return <#return value description#>
 */
- (BOOL)isReachableViaWiFi {
    return self.networkReachabilityStatus == AFNetworkReachabilityStatusReachableViaWiFi;
}

#pragma mark -

- (void)startMonitoring {
    // 取消之前的监听
    [self stopMonitoring];

    if (!self.networkReachability) {
        return;
    }

    __weak __typeof(self)weakSelf = self;
    AFNetworkReachabilityStatusBlock callback = ^(AFNetworkReachabilityStatus status) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        
        // 每次回调被调用，都更新当前的网络状态
        strongSelf.networkReachabilityStatus = status;
        // 调用networkReachabilityStatusBlock
        if (strongSelf.networkReachabilityStatusBlock) {
            strongSelf.networkReachabilityStatusBlock(status);
        }

    };

    // 创建一个SCNetworkReachabilityContext
    SCNetworkReachabilityContext context = {0, (__bridge void *)callback, AFNetworkReachabilityRetainCallback, AFNetworkReachabilityReleaseCallback, NULL};
    // 当目标的网络状态改变时，会调用传入的回调
    SCNetworkReachabilitySetCallback(self.networkReachability, AFNetworkReachabilityCallback, &context);
    // 在Main Runloop中对应的模式开始监控网络状态
    SCNetworkReachabilityScheduleWithRunLoop(self.networkReachability, CFRunLoopGetMain(), kCFRunLoopCommonModes);

    /*
     dispatch_get_global_queue(优先级:优先执行任务，暂无:默认传0) 全局线程 default
     // 优先级从高到低
     #define DISPATCH_QUEUE_PRIORITY_HIGH 2
     #define DISPATCH_QUEUE_PRIORITY_DEFAULT 0
     #define DISPATCH_QUEUE_PRIORITY_LOW (-2)
     #define DISPATCH_QUEUE_PRIORITY_BACKGROUND INT16_MIN
     */
    // 获取当前的网络状态，调用callback
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),^{
        SCNetworkReachabilityFlags flags;
        if (SCNetworkReachabilityGetFlags(self.networkReachability, &flags)) {
            AFPostReachabilityStatusChange(flags, callback);
        }
    });
}


/**
 停止网络监听
 */
- (void)stopMonitoring {
    if (!self.networkReachability) {
        return;
    }
    
    // 使用 SCNetworkReachabilityUnscheduleFromRunLoop 方法取消之前在 Main Runloop 中的监听
    SCNetworkReachabilityUnscheduleFromRunLoop(self.networkReachability, CFRunLoopGetMain(), kCFRunLoopCommonModes);
}

#pragma mark -

- (NSString *)localizedNetworkReachabilityStatusString {
    return AFStringFromNetworkReachabilityStatus(self.networkReachabilityStatus);
}

#pragma mark -

- (void)setReachabilityStatusChangeBlock:(void (^)(AFNetworkReachabilityStatus status))block {
    self.networkReachabilityStatusBlock = block;
}

#pragma mark - NSKeyValueObserving

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
    if ([key isEqualToString:@"reachable"] || [key isEqualToString:@"reachableViaWWAN"] || [key isEqualToString:@"reachableViaWiFi"]) {
        return [NSSet setWithObject:@"networkReachabilityStatus"];
    }

    return [super keyPathsForValuesAffectingValueForKey:key];
}

@end
#endif
