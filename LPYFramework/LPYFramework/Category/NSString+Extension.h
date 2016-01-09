//
//  NSString+Extension.h
//  QQMProject
//
//  Created by admin on 15/11/20.
//  Copyright © 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
// 将NSString转换成UTF8编码的NSString
- (NSString *)getUTF8String;

// 将NSString格式json转化为NSArray或者NSDictionary
- (id)jsonValue;

@end
