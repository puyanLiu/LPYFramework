
//
//  NSString+Extension.m
//  QQMProject
//
//  Created by admin on 15/11/20.
//  Copyright © 2015年 admin. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
- (NSString *)getUTF8String
{
   return (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(nil, (CFStringRef)self, nil,(CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8));
}

- (id)jsonValue;
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

@end
