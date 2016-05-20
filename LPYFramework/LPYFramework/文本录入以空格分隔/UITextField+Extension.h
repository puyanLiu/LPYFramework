//
//  UITextField+Extension.h
//  QQMProject
//
//  Created by admin on 15/11/25.
//  Copyright © 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Extension)

- (NSRange)selectedRange;

- (void)setSelectedRange:(NSRange)range;

/**
 *  设置空格插入的位置 使用方式
 *  - textField:shouldChangeCharactersInRange:replacementString: 
 *  执行如下代码
 *  NSArray *insertPosition = @[@(6), @(10), @(14), @(18)];
 *  [textField insertWhitSpaceInsertPosition:insertPosition replacementString:string textlength:20];
 *  return NO;
 *
 *  @param insertPosition 插入的位置
 *  @param string         插入的字符串
 *  @param length         文本长度
 */
- (void)insertWhitSpaceInsertPosition:(NSArray *)insertPosition replacementString:(NSString *)string textlength:(NSInteger)length;

@end
