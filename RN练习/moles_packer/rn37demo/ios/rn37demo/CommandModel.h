//
//  CommandModel.h
//  rn37demo
//
//  Created by liupuyan on 16/12/23.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CommandModel : NSObject
/**
 *  标题
 */
@property (nonatomic, strong) NSString *name;
/**
 *  子标题
 */
@property (nonatomic, strong) NSString *subtitle;
/**
 *  点击执行的block
 */
@property (nonatomic, copy) void(^block)();
@end
