//
//  UITableView+QQMTableViewPlaceHolder.m
//  QQMProject
//
//  Created by admin on 16/4/24.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "UITableView+QQMTableViewPlaceHolder.h"
#import "QQMTableViewPlaceHolderDelegate.h"

#import <objc/runtime.h>

@interface UITableView ()

/**
 *  是否可以滚动
 */
@property (nonatomic, assign) BOOL scrollWasEnabled;
/**
 *  占位视图
 */
@property (nonatomic, strong) UIView *placeHolderView;

@end

@implementation UITableView (QQMTableViewPlaceHolder)

- (BOOL)scrollWasEnabled {
    NSNumber *scrollWasEnabledObject = objc_getAssociatedObject(self, @selector(scrollWasEnabled));
    return [scrollWasEnabledObject boolValue];
}

- (void)setScrollWasEnabled:(BOOL)scrollWasEnabled {
    NSNumber *scrollWasEnabledObject = [NSNumber numberWithBool:scrollWasEnabled];
    // 动态添加属性
    objc_setAssociatedObject(self, @selector(scrollWasEnabled), scrollWasEnabledObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)placeHolderView {
    return objc_getAssociatedObject(self, @selector(placeHolderView));
}

- (void)setPlaceHolderView:(UIView *)placeHolderView {
    objc_setAssociatedObject(self, @selector(placeHolderView), placeHolderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)qqm_reloadData {
    [self reloadData];
    [self qqm_checkEmpty];
}

- (void)qqm_checkEmpty {
    
    self.placeHolderView = nil;
    
    // isEmpty YES 空数据，NO 存在数据
    BOOL isEmpty = YES;
    
    id<UITableViewDataSource> src = self.dataSource;
    // 获取tableView组数
    NSInteger sections = 1;
    if ([src respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sections = [src numberOfSectionsInTableView:self];
    }
    // 若存在数据，设置isEmpty为NO
    for (int i = 0; i < sections; i++) {
        NSInteger rows = [src tableView:self numberOfRowsInSection:i];
        if (rows) {
            isEmpty = NO;
        }
    }
    
    /*
     进入条件
     1) 空数据并且不存在占位视图
     2) 非空数据并且存在占位视图
     */
    if (isEmpty == !self.placeHolderView) {
        if (isEmpty) {
            // 空数据 && 不存在占位视图
            self.scrollWasEnabled = self.scrollEnabled;
            BOOL scrollEnabled = NO;
            if ([self respondsToSelector:@selector(enableScrollWhenPlaceHolderViewShowing)]) {
                scrollEnabled = [self performSelector:@selector(enableScrollWhenPlaceHolderViewShowing)];
                if (!scrollEnabled) {
                    NSString *reason = @"`-enableScrollWhenPlaceHolderViewShowing`此方法不需要返回NO，它的默认值就是NO";
                    @throw [NSException exceptionWithName:NSGenericException
                                                   reason:reason
                                                 userInfo:nil];
                }
            } else if ([self.delegate respondsToSelector:@selector(enableScrollWhenPlaceHolderViewShowing)]) {
                scrollEnabled = [self.delegate performSelector:@selector(enableScrollWhenPlaceHolderViewShowing)];
                if (!scrollEnabled) {
                    NSString *reason = @"`-enableScrollWhenPlaceHolderViewShowing`此方法不需要返回NO，它的默认值就是NO";
                    @throw [NSException exceptionWithName:NSGenericException
                                                   reason:reason
                                                 userInfo:nil];
                }
            }
            self.scrollEnabled = scrollEnabled;
            if ([self respondsToSelector:@selector(makePlaceHolderView)]) {
                self.placeHolderView = [self performSelector:@selector(makePlaceHolderView)];
            } else if ([self.delegate respondsToSelector:@selector(makePlaceHolderView)]) {
                self.placeHolderView = [self.delegate performSelector:@selector(makePlaceHolderView)];
            } else {
                /*
                    OC的编译器在编译后会在每个方法中加两个隐藏的参数：
                    _cmd:当前方法的一个SEL指针
                    self:指向当前对象的一个指针
                 */
                NSString *selectorName = NSStringFromSelector(_cmd);
                NSString *reason = [NSString stringWithFormat:@"如果你想使用%@方法，你必须在你定义tableView中或者在它代理类中实现`makePlaceHolderView`方法", selectorName];
                @throw [NSException exceptionWithName:NSGenericException
                                               reason:reason
                                             userInfo:nil];
            }
            self.placeHolderView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
            [self addSubview:self.placeHolderView];
        } else {
            // 存在数据 移除占位视图
            self.scrollEnabled = self.scrollWasEnabled;
            [self.placeHolderView removeFromSuperview];
            self.placeHolderView = nil;
        }
    } else if (isEmpty) {
        // tableView不存在数据
        [self.placeHolderView removeFromSuperview];
        // 确保占位视图始终处于最上层
        [self addSubview:self.placeHolderView];
    }
}

@end
