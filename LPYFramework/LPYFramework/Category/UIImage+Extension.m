//
//  UIImage+Extension.m
//  QQMProject
//
//  Created by admin on 15/10/19.
//  Copyright © 2015年 admin. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+(instancetype)imageRenderingModeAlwaysOriginalNamed:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}

+ (instancetype)imageStretchableWithNamed:(NSString *)name
{
    // 设置背景颜色
    UIImage *image = [UIImage imageNamed:name];
    // 设置图片拉伸部分
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    return image;
}

- (instancetype)imageStyle
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctr, rect);
    // 裁剪
    CGContextClip(ctr);
    
    [self drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

// 圆形图片
+ (instancetype)imageCircleWithNamed:(NSString *)imageNamed border:(CGFloat)border borderColoc:(UIColor *)borderColor
{
    UIImage *image = [UIImage imageNamed:imageNamed];
    return [self imageCircleWithImage:image border:border borderColoc:borderColor];
}

// 圆形图片
+ (instancetype)imageCircleWithImage:(UIImage *)image border:(CGFloat)border borderColoc:(UIColor *)borderColor
{
    CGFloat imageWH = image.size.width;
    // 上下文的尺寸
    CGFloat contextWH = imageWH + 2 * border;
    // NO 表示透明  YES 表示不透明
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(contextWH, contextWH), NO, 0);
    
    UIBezierPath *path1 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, contextWH, contextWH)];
    [borderColor setFill];
    [path1 setLineWidth:border];
    [path1 fill];
    
    UIBezierPath *path2 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(border, border, imageWH, imageWH)];
    [path2 fill];
    [path2 addClip];
    
    [image drawInRect:CGRectMake(border, border, imageWH, imageWH)];
    
    UIImage *clipImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return clipImage;
}

/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 */
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    UIImage *newImage = [UIImage imageWithCGImage:scaledImage];
    CFRelease(cs);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    CFRelease(scaledImage);
    return newImage;
}

- (NSString *)getBase64
{
    NSData *data = UIImageJPEGRepresentation(self, 0.01);
    return [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

- (NSInteger)getLength
{
    NSData *data = UIImageJPEGRepresentation(self, 0.01);
    return data.length;
}

// 获取加载图片
+ (UIImage *)getLoadImageWithRect:(CGRect)rect {
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddRect(ctx, rect);
    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextFillPath(ctx);
    CGFloat imageW = 109;
    CGFloat imageH = 44;
    CGRect imageRect = CGRectMake((rect.size.width - imageW) * 0.5, (rect.size.height - imageH) * 0.5, imageW, imageH);
    UIImage *loadImage = [UIImage imageNamed:@"load.."];
    [loadImage drawInRect:imageRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)imageWithImagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image;
    if (picker.sourceType == UIImagePickerControllerSourceTypeSavedPhotosAlbum) {
        image = info[UIImagePickerControllerEditedImage];
    } else {
        image = info[UIImagePickerControllerOriginalImage];
        UIImageOrientation imageOrientation = image.imageOrientation;
        if (imageOrientation != UIImageOrientationUp) {
            UIGraphicsBeginImageContext(image.size);
            [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
            image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
    }
    return image;
}
@end
