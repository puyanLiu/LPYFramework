//
//  LPYPhoneProtocol.h
//  LPYFramework
//
//  Created by admin on 16/1/27.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LPYPhoneProtocol <NSObject>

@required

/**
 *  打电话
 */
- (void)phoneCall;

/**
 *  发短信
 */
- (void)sendMessage;

@end
