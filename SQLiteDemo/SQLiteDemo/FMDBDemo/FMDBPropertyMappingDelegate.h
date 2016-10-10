//
//  FMDBPropertyMappingDelegate.h
//  SQLiteDemo
//
//  Created by liupuyan on 16/10/9.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FMDBPropertyMappingDelegate <NSObject>

@required
- (NSDictionary *)fmdbPropertyMapping;

@end
