//
//  LPYSubscriptionServiceCenterProtocol.h
//  LPYFramework
//
//  Created by admin on 16/1/18.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LPYSubscriptionServiceCenterProtocol <NSObject>

- (void)subscriptionMessage:(id)message subscriptionNumber:(NSString *)subscriptionNumber;

@end
