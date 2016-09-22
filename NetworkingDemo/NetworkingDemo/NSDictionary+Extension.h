//
//  NSDictionary+Extension.h
//  QQMProject
//
//  Created by admin on 15/11/3.
//  Copyright © 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Extension)

/**
 *  把JSON格式的字符串转换成字典
 *
 *  @param jsonString 需要转换的JSON字符串
 *
 *  @return 转换成功的字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

@end
