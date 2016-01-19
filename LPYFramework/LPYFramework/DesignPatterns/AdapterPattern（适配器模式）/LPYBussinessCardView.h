//
//  LPYBussinessCardView.h
//  LPYFramework
//
//  Created by admin on 16/1/14.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPYBussinessCardAdapterProtocol.h"

#define  BUSINESS_FRAME  CGRectMake(0, 0, 200, 130)

@interface LPYBussinessCardView : UIView

// 赋值数据
@property (nonatomic, strong) id<LPYBussinessCardAdapterProtocol> bussinessCardData;

@end
