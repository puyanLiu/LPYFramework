//
//  UIImage+Extension.h
//  QQMProject
//
//  Created by admin on 15/10/19.
//  Copyright © 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
/**
 *  图片显示原来的内容，不被渲染
 *
 *  @return <#return value description#>
 */
+ (instancetype)imageRenderingModeAlwaysOriginalNamed:(NSString *)name;

/**
 *  图片中间部分拉伸
 *
 *  @param name <#name description#>
 *
 *  @return <#return value description#>
 */
+ (instancetype)imageStretchableWithNamed:(NSString *)name;

/**
 *  图片样式
 *
 *  @param image <#image description#>
 *
 *  @return <#return value description#>
 */
- (instancetype)imageStyle;

// 圆形图片
+ (instancetype)imageCircleWithImage:(UIImage *)image border:(CGFloat)border borderColoc:(UIColor *)borderColor;

// 圆形图片
+ (instancetype)imageCircleWithNamed:(NSString *)imageNamed border:(CGFloat)border borderColoc:(UIColor *)borderColor;

/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 */
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size;

- (NSString *)getBase64;

- (NSInteger)getLength;

// 获取加载图片
+ (UIImage *)getLoadImageWithRect:(CGRect)rect;

+ (UIImage *)imageWithImagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info;
@end
