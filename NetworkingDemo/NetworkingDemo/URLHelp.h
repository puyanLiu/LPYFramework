//
//  URLHelp.h
//  QQMProject
//
//  Created by admin on 15/11/30.
//  Copyright © 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLHelp : NSObject

+ (instancetype)shareUrlHelp;

/**
 *  rootURL
 */
@property (nonatomic, copy, readonly) NSString *rootURL;

/**
 *  公共接口URL
 */
@property (nonatomic, copy, readonly) NSString *publicURL;

/**
 *  opiUrl
 */
@property (nonatomic, copy, readonly) NSString *opiURL;
@end
