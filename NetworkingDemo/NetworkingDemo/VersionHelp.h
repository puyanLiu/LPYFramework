//
//  VersionHelp.h
//  QQMProject
//
//  Created by admin on 16/1/4.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VersionHelp : NSObject
+ (instancetype)shareVersionHelp;

/**
 *  当前版本
 */
@property (nonatomic, strong) NSString *getCurrentVersion;
/**
 *  新版本
 */
@property (nonatomic, strong) NSString *getNewVersion;
/**
 *  appstore链接
 */
@property (nonatomic, strong) NSString *getNewURL;

@end
