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

- (NSString *)description
{
    return [NSString stringWithFormat:@"status------%@,des------%@,error------%@,text------%@", self.status, self.statusDes, self.error, self.textDictionary];
}
@end
