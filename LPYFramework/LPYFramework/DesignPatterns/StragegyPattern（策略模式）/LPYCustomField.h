//
//  LPYCustomField.h
//  LPYFramework
//
//  Created by admin on 16/1/15.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPYBaseInputValidator.h"

@interface LPYCustomField : UITextField

// 抽象的策略
@property (nonatomic, strong) LPYBaseInputValidator *validator;

// 验证输入合法性
// 不合法，赌气InputValidator中得errorMessage
- (BOOL)validate;

@end
