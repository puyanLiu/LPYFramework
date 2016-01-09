//
//  NSObject+Extension.m
//  QQMProject
//
//  Created by admin on 15/11/2.
//  Copyright © 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@implementation UIView (dealloc)

+ (void)load
{
//    Method imp = class_getInstanceMethod([self class], @selector(dealloc));
//    Method myImp = class_getInstanceMethod([self class], @selector(myDealloc));
//    method_exchangeImplementations(imp, myImp);
}

- (void)myDealloc
{
    NSLog(@"%@被释放",[self class]);
    [self myDealloc];
}
@end

@implementation UIViewController (dealloc)

+ (void)load
{
    // 需要将此文件标识为非ARC环境运行 -fno-objc-arc
    Method imp = class_getInstanceMethod([self class], @selector(dealloc));
    Method myImp = class_getInstanceMethod([self class], @selector(myDealloc));
    method_exchangeImplementations(imp, myImp);
}

- (void)myDealloc
{
    NSLog(@"%@被释放",[self class]);
    [self myDealloc];
}
@end