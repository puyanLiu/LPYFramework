//
//  BaseModel.m
//  SQLiteDemo
//
//  Created by liupuyan on 16/10/9.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "BaseModel.h"
#import <objc/runtime.h>

@implementation BaseModel

- (NSDictionary *)allMembers {
    NSMutableDictionary *members = [[NSMutableDictionary alloc]init];
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding] ;
        
        NSString *propertyClass = [[NSString alloc] initWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding] ;
        
        [members setObject:@([self returnType:propertyClass]) forKey:propertyName];
    }
    
    free(properties);
    
    return [members copy];
}

/*
 TB,N,V_isHave
 Tq,N,V_num
 T@"NSString",C,N,V_name
 T@"NSArray",C,N,V_arr
 T@"NSDictionary",C,N,V_dic
 T@"NSNumber",C,N,V_age
 */
- (DataType)returnType:(NSString *)T {
    if ([T hasPrefix:@"T@\"NSString\""]) {
        return wTEXT;
    } else if ([T hasPrefix:@"T@\"NSArray\""]) {
        return wArr;
    } else if ([T hasPrefix:@"T@\"NSDictionary\""]) {
        return wDic;
    } else if ([T hasPrefix:@"TB"]) {
        return wBOOL;
    } else if ([T hasPrefix:@"Tq"]) {
        return wINT;
    }
    return wERROR;
}

@end
