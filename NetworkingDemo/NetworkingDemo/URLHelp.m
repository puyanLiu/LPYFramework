//
//  URLHelp.m
//  QQMProject
//
//  Created by admin on 15/11/30.
//  Copyright © 2015年 admin. All rights reserved.
//

#import "URLHelp.h"

@implementation URLHelp

+ (instancetype)shareUrlHelp
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    if(self = [super init]) {
        [self loadData];
    }
    return self;
}

- (void)loadData
{
    _rootURL = @"";
    _publicURL = @"";
    _opiURL = @"";
}

@end
