//
//  QQMResponse.m
//  QQMProject
//
//  Created by admin on 15/11/3.
//  Copyright © 2015年 admin. All rights reserved.
//

#import "QQMResponse.h"
#import "NSDictionary+Extension.h"

@implementation QQMResponse

- (void)setText:(NSString *)text
{
    _text = text;
    // {"status":-101,"des":"名字不能为空"}
    self.textDictionary = [NSDictionary dictionaryWithJsonString:text];
    self.statusDes = self.textDictionary[@"des"] == nil ? @"" : self.textDictionary[@"des"];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"header-----%@,status------%@,message------%@,body------%@,text-----%@,error------%@", self.header, self.status, self.message, self.body, self.text, self.error];
}
@end
