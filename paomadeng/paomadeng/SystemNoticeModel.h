//
//  SystemNoticeModel.h
//  QQMProject
//
//  Created by admin on 16/6/20.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemNoticeModel : NSObject
/**
 *  通知排序号
 */
@property (nonatomic, strong) NSNumber *index;
/**
 *  通知标题
 */
@property (nonatomic, strong) NSString *title;
/**
 *  链接地址
 */
@property (nonatomic, strong) NSString *srcURL;
@end
