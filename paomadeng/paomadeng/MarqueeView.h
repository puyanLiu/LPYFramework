//
//  MarqueeView.h
//  QQMProject
//
//  Created by 刘蒲艳 on 16/5/7.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, MarqueeViewScrollDirection) {
    MarqueeViewScrollDirectionVertical,
    MarqueeViewScrollDirectionHorizontal
};

@interface MarqueeView : UIScrollView

/**
 *  定时器
 */
@property (nonatomic,strong) CADisplayLink *timer;

/**
 *  需要展示的视图数组
 */
@property (nonatomic,strong) NSMutableArray *views;

/**
 *  是否可交互 default is YES
 */
@property (nonatomic,assign) BOOL isUserInteraction;

/**
 *  水平垂直居中
 */
@property (nonatomic,assign) BOOL isCenterVertical;

/**
 *  view之前间距
 */
@property (nonatomic,assign) CGFloat margin;

/**
 *  速度
 */
@property (nonatomic,assign) NSInteger speed;

/**
 *  滚动方向 default is MarqueeViewScrollDirectionHorizontal
 */
@property (nonatomic,assign) MarqueeViewScrollDirection scrollDirection;

/**
 *  停留时间 MarqueeViewScrollDirectionVertical时使用 default is 3 second
 */
@property (nonatomic,assign) NSInteger rowDuration;

- (void)fire;

- (void)stop;

@end
