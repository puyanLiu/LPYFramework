//
//  MarqueeView.m
//  QQMProject
//
//  Created by 刘蒲艳 on 16/5/7.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "MarqueeView.h"

@interface MarqueeView ()
/**
 *  firstView
 */
@property (nonatomic,weak) UIView *firstView;

/**
 *  self.contentOffsetX
 */
@property (nonatomic,assign) CGFloat displayX;

/**
 *  self.contentOffsetY
 */
@property (nonatomic,assign) CGFloat displayY;

/**
 *  停止滚动
 */
@property (nonatomic,assign) NSInteger sleepCount;
@end

@implementation MarqueeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.isCenterVertical = YES;
        self.margin = 10;
        self.speed = 1;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.scrollDirection = MarqueeViewScrollDirectionHorizontal;
        self.rowDuration = 3;
        self.sleepCount = 0;
    }
    return self;
}

- (CADisplayLink *)timer
{
    if(_timer == nil)
    {
        _timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(moveInCircle)];
        [_timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    
    return _timer;
}

- (void)moveInCircle {
    if (self.scrollDirection == MarqueeViewScrollDirectionHorizontal) {
        if (self.displayX <= self.frame.size.width) {
            [self stop];
            return;
        }
        if (self.contentOffset.x >= self.displayX) {
            [self setContentOffset:CGPointZero];
        }
        self.contentOffset = CGPointMake(self.contentOffset.x + 1 * self.speed, 0);
    } else if (self.scrollDirection == MarqueeViewScrollDirectionVertical) {
        if ((NSInteger)self.contentOffset.y % (NSInteger)self.frame.size.height == 0
            && self.sleepCount != self.rowDuration * 60) {
            // 停留
            self.sleepCount++;
            return;
        }
        self.sleepCount = 0;
        if (self.contentOffset.y >= self.displayY) {
            [self setContentOffset:CGPointZero];
        }
        self.contentOffset = CGPointMake(0, self.contentOffset.y + 1 * self.speed);
    }
}

- (void)setViews:(NSMutableArray *)views {
    if (views == nil || views.count == 0) {
        return;
    }
    _views = views;
    
    if (self.scrollDirection == MarqueeViewScrollDirectionVertical) {
        if ([[views firstObject] isKindOfClass:[UIView class]]) {
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[views firstObject]];
            self.firstView = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [_views addObject:self.firstView];
        }
    }
}

- (void)setIsUserInteraction:(BOOL)isUserInteraction {
    _isUserInteraction = isUserInteraction;
    self.userInteractionEnabled = isUserInteraction;
}

- (void)fire {
    if (self.scrollDirection == MarqueeViewScrollDirectionVertical) {
        if (self.views.count > 2) {
            [self timer];
        }
    } else {
        [self timer];
    }
}

- (void)stop {
    [self.timer invalidate];
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    [super willMoveToWindow:newWindow];
    if (self.scrollDirection == MarqueeViewScrollDirectionVertical) {
        NSAssert(self.views.count >= 2, @"count of views must > 1");
    } else {
        NSAssert(self.views.count >= 1, @"count of views must > 0");
    }
    
    if (self.scrollDirection == MarqueeViewScrollDirectionHorizontal) {
        __block CGFloat width = 0.0;
        
        [self.views enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[UIView class]]) {
                UIView *view = obj;
                CGFloat viewW = view.frame.size.width;
                CGFloat viewH = view.frame.size.height;
                width += self.margin;
                
                if (self.isCenterVertical) {
                    CGFloat viewY = (self.frame.size.height - viewH) * 0.5;
                    view.frame = CGRectMake(width, viewY, viewW, viewH);
                }
                width += viewW;
                [self addSubview:view];
                if (self.views.count - 1 == idx) {
                    self.displayX = width;
                }
            }
        }];
    } else if (self.scrollDirection == MarqueeViewScrollDirectionVertical) {
        __block CGFloat height = 0.0;
        CGFloat viewW = self.frame.size.width;
        CGFloat viewH = self.frame.size.height;
        
        [self.views enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[UIView class]]) {
                UIView *view = obj;
                view.frame = CGRectMake(0, height, viewW, viewH);
                [self addSubview:view];
                height += viewH;
                if (self.views.count - 2 == idx) {
                    self.displayY = height;
                }
            }
        }];
    }
}

@end
