//
//  QQMPlaceHolderView.h
//  QQMProject
//
//  Created by admin on 16/4/25.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QQMPlaceHolderViewDelegate <NSObject>

@required
- (void)emptyOverlayClicked: (id)sender;

@end

@interface QQMPlaceHolderView : UIView

/**
 *  delegate
 */
@property (nonatomic, weak) id<QQMPlaceHolderViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame;

@end
