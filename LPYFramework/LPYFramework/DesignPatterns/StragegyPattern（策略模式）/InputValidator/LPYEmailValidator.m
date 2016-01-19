//
//  LPYEmailValidator.m
//  LPYFramework
//
//  Created by admin on 16/1/15.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYEmailValidator.h"
#import "RegExCategories.h"

@implementation LPYEmailValidator

// 重载父类的验证方法
- (BOOL)validateInput:(UITextField *)input {
    if (input.text.length <= 0) {
        self.errorMessage = @"请输入邮箱";
        return NO;
    }
    
    BOOL isMatch = [input.text isMatch:RX(@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}")];
    if (!isMatch) {
        // 验证不通过
        self.errorMessage = @"邮箱输入有误";
        return NO;
    }
    
    self.errorMessage = nil;
    return YES;
}

@end
