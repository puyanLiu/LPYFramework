//
//  LPYBussinessNewCardModel.h
//  LPYFramework
//
//  Created by admin on 16/1/14.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPYBussinessNewCardModel : NSObject
/**
 *  名字
 */
@property (nonatomic, strong) NSString *name;

/**
 *  线条颜色
 */
@property (nonatomic, strong) NSString *colorHexString;

/**
 *  电话号码
 */
@property (nonatomic, strong) NSString *phoneNumber;
@end
