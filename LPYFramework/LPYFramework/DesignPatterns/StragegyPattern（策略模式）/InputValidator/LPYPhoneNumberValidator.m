//
//  LPYPhoneNumberValidator.m
//  LPYFramework
//
//  Created by admin on 16/1/15.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYPhoneNumberValidator.h"
#import "RegExCategories.h"

@implementation LPYPhoneNumberValidator

// 重载父类的验证方法
- (BOOL)validateInput:(UITextField *)input {
    if (input.text.length <= 0) {
        self.errorMessage = @"请输入电话号码";
        return NO;
    }
    
    BOOL isMatch = [input.text isMatch:RX(@"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$")];
    if (!isMatch) {
        // 验证不通过
        self.errorMessage = @"电话号码输入有误";
        return NO;
    }
    
    self.errorMessage = nil;
    return YES;
}

@end
