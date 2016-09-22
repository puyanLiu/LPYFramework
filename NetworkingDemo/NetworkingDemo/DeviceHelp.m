//
//  DeviceHelp.m
//  QQMProject
//
//  Created by admin on 15/12/2.
//  Copyright © 2015年 admin. All rights reserved.
//

#import "DeviceHelp.h"
#import <CoreTelephony/CoreTelephonyDefines.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <sys/utsname.h>
#import "VersionHelp.h"
#import <UIKit/UIKit.h>

@interface DeviceHelp()
@end

@implementation DeviceHelp

static NSString *clientStr;

+ (void)load
{
    NSMutableString *client = [NSMutableString string];
    
    // 设备制造商
    NSString *manufacturer = @"Apple";
    // 设备类型
    NSString *model = [UIDevice currentDevice].localizedModel;
    // UUID
    NSString *uuid = [UIDevice currentDevice].identifierForVendor.UUIDString;
    // 设备识别码
    NSString *imei = @"";
    [client appendFormat:@"device=￼manufacturer:%@, model:%@, uuid:%@,imei/meid:%@;", manufacturer, model, uuid, imei];
    // 系统名/版本号
    NSString *system = [self deviceString];
    NSString *version = [UIDevice currentDevice].systemVersion;
    [client appendFormat:@"system=%@/%@;", system, version];
    
    CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
    
    CTCarrier *carrier = [telephonyInfo subscriberCellularProvider];
    // 运营商
//    NSString *currentCountry=[carrier carrierName];
    // 手机号
    NSString *number = @"";
    // sim卡序列号
    NSString *serial = @"";
    // 移动网络国家码
    NSString *mcc = [carrier mobileCountryCode];
    // 移动网络类型码
    NSString *mnc = [carrier mobileNetworkCode];
    [client appendFormat:@"sim=￼number:%@, serial:%@, mcc:%@,mnc:%@;", number, serial, mcc, mnc];
    // 平台版本号
    NSString *app = [NSString stringWithFormat:@"ios-­native/%@", [VersionHelp shareVersionHelp].getCurrentVersion];
    [client appendFormat:@"app=%@;", app];
    NSString *sourceInfoString = @"Appstore";
    [client appendFormat:@"source=%@;", sourceInfoString];
    clientStr = client;
}

+ (NSString *)deviceString
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    
    if ([deviceString isEqualToString:@"iPhone3,3"])    return @"Verizon iPhone 4";
    
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2 (WiFi)";
    
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3 (GSM)";
    
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    
    if ([deviceString isEqualToString:@"iPad4,3"])      return @"iPad Air";
    
    if ([deviceString isEqualToString:@"iPad4,4"])      return @"iPad Mini 2G (WiFi)";
    
    if ([deviceString isEqualToString:@"iPad4,5"])      return @"iPad Mini 2G (Cellular)";
    
    if ([deviceString isEqualToString:@"iPad4,6"])      return @"iPad Mini 2G";
    
    if ([deviceString isEqualToString:@"iPad4,7"])      return @"iPad Mini 3 (WiFi)";
    
    if ([deviceString isEqualToString:@"iPad4,8"])      return @"iPad Mini 3 (Cellular)";
    
    if ([deviceString isEqualToString:@"iPad4,9"])      return @"iPad Mini 3 (China)";
    
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2 (WiFi)";
    
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2 (Cellular)";
    
    if ([deviceString isEqualToString:@"AppleTV2,1"])  return @"Apple TV 2G";
    
    if ([deviceString isEqualToString:@"AppleTV3,1"])  return @"Apple TV 3";
    
    if ([deviceString isEqualToString:@"AppleTV3,2"])  return @"Apple TV 3 (2013)";
    
    if ([deviceString isEqualToString:@"i386"])        return @"Simulator";
    
    if ([deviceString isEqualToString:@"x86_64"])      return @"Simulator";
    
    NSLog(@"NOTE: Unknown device type: %@", deviceString);
    return deviceString;
}

+ (NSString *)getDevice
{
    return clientStr;
}

+ (NSString*)uuid {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}
@end
