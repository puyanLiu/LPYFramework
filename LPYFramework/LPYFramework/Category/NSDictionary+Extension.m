//
//  NSDictionary+Extension.m
//  QQMProject
//
//  Created by admin on 15/11/3.
//  Copyright © 2015年 admin. All rights reserved.
//

#import "NSDictionary+Extension.h"

@implementation NSDictionary (Extension)

// 把JSON格式的字符串转换成字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
            options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
@end
