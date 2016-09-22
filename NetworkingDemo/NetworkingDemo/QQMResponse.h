//
//  QQMResponse.h
//  QQMProject
//
//  Created by admin on 15/11/3.
//  Copyright © 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

// 对返回信息的封装
@interface QQMResponse : NSObject
/**
 *  header 头信息
 */
@property (nonatomic, strong) NSDictionary *header;
/**
 *  status 状态信息
 */
@property (nonatomic, strong) NSNumber *status;
/**
 *  状态信息对应的描述
 */
@property (nonatomic, strong) NSString *statusDes;
/**
 *  message 一般只有status是负数的时候才会去看看返回的错误信息
 */
@property (nonatomic, strong) NSString *message;
/**
 *  body 正文信息
 */
@property (nonatomic, strong) NSDictionary *body;
/**
 *  text 页面返回来得原始信息
 */
@property (nonatomic, strong) NSString *text;
/**
 *  text 页面返回来得原始信息 转换为字典
 */
@property (nonatomic, strong) NSDictionary *textDictionary;
/**
 *  error AFN返回给我们的错误信息
 */
@property (nonatomic, strong) NSError *error;
/**
 *  html
 */
@property (nonatomic, strong) NSString *htmlContent;
@end

