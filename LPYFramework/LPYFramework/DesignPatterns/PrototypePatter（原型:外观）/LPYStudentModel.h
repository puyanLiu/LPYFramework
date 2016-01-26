//
//  LPYStudentModel.h
//  LPYFramework
//
//  Created by admin on 16/1/26.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPYPrototypeCopyProtocol.h"

@interface LPYStudentModel : NSObject <LPYPrototypeCopyProtocol>

/**
 *  name
 */
@property (nonatomic, strong) NSString *name;
/**
 *  age
 */
@property (nonatomic, strong) NSNumber *age;
/**
 *  address
 */
@property (nonatomic, strong) NSString *address;
/**
 *  totalScore
 */
@property (nonatomic, strong) NSNumber *totalScore;
@end
