//
//  LPYBussinessCardAdapter.h
//  LPYFramework
//
//  Created by admin on 16/1/14.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPYBussinessCardAdapterProtocol.h"

// 基适配器 其他适配器继承此适配器
@interface LPYBussinessBaseCardAdapter : NSObject <LPYBussinessCardAdapterProtocol>

// 输入对象
@property (nonatomic, weak) id data;

// 与输入对象建立联系
- (instancetype)initWithData:(id)data;

@end
