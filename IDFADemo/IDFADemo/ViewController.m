//
//  ViewController.m
//  IDFADemo
//
//  Created by liupuyan on 16/11/17.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "ViewController.h"
#import <AdSupport/AdSupport.h>
#import "SSKeychain.h"

static NSString * const kQQMDeviceIdentifier = @"kQQMDeviceIdentifier";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 访问UDID的应用将不能再通过审核
//    UDID是设备上的唯一标识，相当于人的身份证，一台手机只会有一个
//    UUID是Universally Unique Identifier的缩写，中文意思是通用唯一识别码。它是让分布式系统中的所有元素，都能有唯一的辨识资讯，而不需要透过中央控制端来做辨识资讯的指定。这样，每个人都可以建立不与其它人冲突的 UUID。在此情况下，就不需考虑数据库建立时的名称重复问题。苹果公司建议使用UUID为应用生成唯一标识字符串。
    
//    [self CFUUIDDemo];
//    [self CFUUIDDemo];
//    
//    [self NSUUIDDemo];
//    [self NSUUIDDemo];
//    
//    [self VendorDemo];
//    [self VendorDemo];
    
    [self IDFADemo];
    [self IDFADemo];
    
    [self getIDFA];
    [self getIDFA];
    
}

/**
 CFUUID
 
 2.0出现 C语言风格
 
 获得CDUUID值系统并没有存储，每次调用CFUUIDCreate，系统都会返回一个新的唯一标示符
 存储：需要自己将其存储到NSUserDefaults, Keychain, Pasteboard或其它地方
 */
- (void)CFUUIDDemo {
    CFUUIDRef cfuuid = CFUUIDCreate(kCFAllocatorDefault);
    NSString *cfuuidString = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, cfuuid));
    NSLog(@"cfuuid---------------------%@", cfuuidString);
}

/**
 NSUUID
 
 iOS 6出现 OC风格

 跟CFUUID几乎完全一样，获得NSUUID值系统不会存储，每次调用的时候都会获得一个新的唯一标示符
 存储：自己存储
*/
- (void)NSUUIDDemo {
    NSString *nsuuid = [[NSUUID UUID] UUIDString];
    NSLog(@"nsuuid---------------------%@", nsuuid);
}

/**
 广告标识符(IDFA-identifierForldentifier)
 
 iOS 6出现 advertisingIdentifier是新框架AdSupport.framework的一部分
 
 广告标识符是🈶系统存储的
 不过即使这是由系统存储的，但是有几种情况下，会重新生成广告标示符。如果用户完全重置系统（(设置程序 -> 通用 -> 还原 -> 还原位置与隐私) ，这个广告标示符会重新生成。另外如果用户明确的还原广告(设置程序-> 隐私 -> 广告 -> 还原广告标示符) ，那么广告标示符也会重新生成。关于广告标示符的还原，有一点需要注意：如果程序在后台运行，此时用户“还原广告标示符”，然后再回到程序中，此时获取广告标示符并不会立即获得还原后的标示符。必须要终止程序，然后再重新启动程序，才能获得还原后的广告标示符。之所以会这样，我猜测是由于ASIdentifierManager是一个单例
 
 针对广告标示符用户有一个可控的开关“限制广告跟踪”。将这个开关打开，实际上什么也没有做，不过这是希望限制你访问广告标示符。这个开关是一个简单的boolean标志，当将广告标示符发到任意的服务器端时，你最好判断一下这个值，然后再做决定
 */
-(void)IDFADemo {
    NSUUID *uuid = [[ASIdentifierManager sharedManager] advertisingIdentifier];
    NSString *adid = [uuid UUIDString];
    NSLog(@"adid---------------------%@", adid);
}

- (NSString *)getIDFA {
    // 在 iOS 10 之后，如果用户手动限制广告跟踪的话（设置-隐私-广告-限制广告跟踪），IDFA 返回的将全是零
    // iOS 之前用户限制广告跟踪的话只是重置 IDFA
    // 从钥匙串中获取唯一标识
    NSString *deviceIdentifier = [SSKeychain passwordForService:[[NSBundle mainBundle] bundleIdentifier] account:kQQMDeviceIdentifier];
    if (deviceIdentifier) {
        NSLog(@"ssk get adid---------------------%@", deviceIdentifier);
        return deviceIdentifier;
    }
    // 获取IDFA
    NSUUID *uuid = [[ASIdentifierManager sharedManager] advertisingIdentifier];
    NSString *idfa = [uuid UUIDString];
    // 判断idfa是否为空
    BOOL isEmpty = [[idfa stringByReplacingOccurrencesOfString:@"-" withString:@""] stringByReplacingOccurrencesOfString:@"0" withString:@""].length;
    if (isEmpty) {
        // 不为空
        deviceIdentifier = idfa;
    }
    // 保存唯一设备标识
    [SSKeychain setPassword:deviceIdentifier forService:[[NSBundle mainBundle] bundleIdentifier] account:kQQMDeviceIdentifier];
    
    NSLog(@"ssk set adid---------------------%@", idfa);
    return deviceIdentifier;
}

/**
 Vendor标示符(IDFV-identifierForVendor)
 
 iOS 6新增
 
 相同的程序-相同的vindor-相同的设备，获取到的这个值相同
 相同的程序-相同的设备-不同的vindor || 相同的程序-不同的设备-无论是否相同的vindor，获取的这个值是不同的
 
 Vindor：一个Vendor是CFBundleIdentifier(反转DNS格式)的前两部分，例如com.doubleencore.app1 和 com.doubleencore.app2 得到的identifierForVendor是相同的，因为它们的CFBundleIdentifier前两部分是相同的
 
 如果用户卸载了同一个vendor对应的应用程序，然后在重新安装同一个vendor提供的程序，此时identifierForVendor会被重置
 */
- (void)VendorDemo {
    NSUUID *uuid = [[UIDevice currentDevice] identifierForVendor];
    NSString *idfv = [uuid UUIDString];
    NSLog(@"idfv---------------------%@", idfv);
}

/**
 UDID
 
 iOS 5以及之后的版本被弃用
 */
- (void)UDIDDemo {
//    NSString *udid = [[UIDevice currentDevice] uniqueIdentifier];
}

/**
 OpenUDID
 
 在iOS 5发布时，uniqueIdentifier被弃用了，这引起了广大开发者需要寻找一个可以替代UDID，并且不受苹果控制的方案。由此OpenUDID成为了当时使用最广泛的开源UDID替代方案。OpenUDID在工程中实现起来非常简单，并且还支持一系列的广告提供商。
 
 
 */
- (void)OpenUDID {
//    NSString *oepnudid = [OpenUDID value];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
