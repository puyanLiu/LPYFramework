//
//  VersionHelp.m
//  QQMProject
//
//  Created by admin on 16/1/4.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "VersionHelp.h"
#import "NSDictionary+Extension.h"

@implementation VersionHelp
+ (instancetype)shareVersionHelp {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)loadData
{
    // 新版本
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/lookup?id=%@", @""]];
    
    NSError *error = nil;
    NSString *file = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    
    if (!error) {
        NSDictionary *dict = [NSDictionary dictionaryWithJsonString:file];
        NSString *newVersion = [dict[@"results"] firstObject][@"version"];// 最新版本
        _getNewVersion = newVersion;
        
        // appstore链接
        NSString *newUrl = [dict[@"results"] firstObject][@"trackViewUrl"];
        _getNewURL = newUrl;
    }
}

- (NSString *)getCurrentVersion
{
    if(!_getCurrentVersion)
    {
        // 当前版本
        _getCurrentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    }
    return _getCurrentVersion;
}

- (NSString *)getNewVersion
{
    if(!_getNewVersion)
    {
        [self loadData];
    }
    return _getNewVersion;
}

- (NSString *)getNewURL
{
    if(!_getNewURL)
    {
        [self loadData];
    }
    return _getNewURL;
}

@end
