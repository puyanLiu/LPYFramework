//
//  UITableView+QQMTableViewPlaceHolder.h
//  QQMProject
//
//  Created by admin on 16/4/24.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (QQMTableViewPlaceHolder)

/**
 *  使用这个方法来替换tableView的`reloadData`，并且它能自动的帮你添加或删除占位视图
 *  注：这个方法已经执行了tableView的reloadData，因此你不需要再执行tableView的reloadData
 */
- (void)qqm_reloadData;

@end
