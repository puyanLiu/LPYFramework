//
//  LPYBaseInputValidator.h
//  LPYFramework
//
//  Created by admin on 16/1/15.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LPYBaseInputValidator : NSObject

// 当validateInput为NO的时候，errorMessage为错误信息
@property (nonatomic, strong) NSString *errorMessage;

// 策略的输入
// YES：表示测试通过
// NO：表示测试不通过
- (BOOL)validateInput:(UITextField *)input;
@end
