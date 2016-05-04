//
//  QQMNetReloader.h
//  QQMProject
//
//  Created by admin on 16/4/25.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReloadButtonClickBlock)();

@interface QQMNetReloader : UIView

- (instancetype)initWithFrame:(CGRect)frame reloadBlock:(ReloadButtonClickBlock)reloadBlock;

- (void)showInView:(UIView *)viewWillShow;
- (void)dismiss;

@end
