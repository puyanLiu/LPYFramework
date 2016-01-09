//
//  NSDictionary+Extension.h
//  QQMProject
//
//  Created by admin on 15/11/3.
//  Copyright © 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Extension)

// 把JSON格式的字符串转换成字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

@end
