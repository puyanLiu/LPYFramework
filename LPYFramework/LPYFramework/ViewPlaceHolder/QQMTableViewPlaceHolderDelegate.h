//
//  QQMTableViewPlaceHolderDelegate.h
//  QQMProject
//
//  Created by admin on 16/4/24.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol QQMTableViewPlaceHolderDelegate <NSObject>

@required
/**
 *  当tableView无数据时显示的View
 *
 *  @return 占位视图
 */
- (UIView *)makePlaceHolderView;

@optional
/**
 *  当占位视图显示的时候，tableView能否滚动，默认是禁用的
 *
 *  @return 返回YES，tableView可以滚动
 */
- (BOOL)enableScrollWhenPlaceHolderViewShowing;

@end
