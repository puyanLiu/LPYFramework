//
//  LPYCircle.m
//  LPYFramework
//
//  Created by admin on 16/1/18.
//  Copyright © 2016年 liupuyan. All rights reserved.
//

#import "LPYCircle.h"
#import "LPYCircleViewConst.h"

@interface LPYCircle ()

/**
 *  外环颜色
 */
@property (nonatomic, strong) UIColor *outCircleColor;

/**
 *  实心圆颜色
 */
@property (nonatomic, strong) UIColor *inCircleColor;

/**
 *  三角形颜色
 */
@property (nonatomic, strong) UIColor *trangleColor;
@end

@implementation LPYCircle

- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.backgroundColor = CircleBackgroundColor;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGFloat radio;
    CGRect circleRect = CGRectMake(CircleEdgeWidth, CircleEdgeWidth, rect.size.width - 2 * CircleEdgeWidth, rect.size.height - 2 * CircleEdgeWidth);
    
    if (self.type == LPYCircleTypeGesture) {
        radio = CircleRadio;
    } else if (self.type == LPYCircleTypeInfo) {
        radio = 1;
    }
    
    // 上下文旋转
    [self transFormCtx:ctx rect:rect];
    
    // 画圆环
    [self drawEmptyCircleWithContext:ctx rect:circleRect color:self.outCircleColor];
    
    // 画实心圆
    [self drawSolidCircleWithContext:ctx rect:rect radio:radio color:self.inCircleColor];
    
    if (self.arrow) {
        // 画三角形箭头
        [self drawTrangleWithContext:ctx topPoint:CGPointMake(rect.size.width/2, 10) length:kTrangleLength color:self.trangleColor];
    }
}

#pragma mark - 画外圆环
/**
 *  画外圆环
 *
 *  @param ctx   图形上下文
 *  @param rect  绘画范围
 *  @param color 绘制颜色
 */
- (void)drawEmptyCircleWithContext:(CGContextRef)ctx rect:(CGRect)rect color:(UIColor *)color {
    CGMutablePathRef circlePath = CGPathCreateMutable();
    CGPathAddEllipseInRect(circlePath, NULL, rect);
    CGContextAddPath(ctx, circlePath);
    [color set];
    CGContextSetLineWidth(ctx, CircleEdgeWidth);
    CGContextStrokePath(ctx);
    CGPathRelease(circlePath);
}

#pragma mark - 画实心圆
/**
 *  画实心圆
 *
 *  @param ctx   图形上下文
 *  @param rect  绘制范围
 *  @param radio 占大圆比例
 *  @param color 绘制颜色
 */
- (void)drawSolidCircleWithContext:(CGContextRef)ctx rect:(CGRect)rect radio:(CGFloat)radio color:(UIColor *)color {
    CGMutablePathRef circlePath = CGPathCreateMutable();
    CGPathAddEllipseInRect(circlePath, NULL, CGRectMake(rect.size.width/2 * (1 - radio) + CircleEdgeWidth, rect.size.height/2 * (1 - radio) + CircleEdgeWidth, rect.size.width * radio - CircleEdgeWidth * 2, rect.size.height * radio - CircleEdgeWidth * 2));
    [color set];
    CGContextAddPath(ctx, circlePath);
    CGContextFillPath(ctx);
    CGPathRelease(circlePath);
}

#pragma mark - 画三角形
/**
 *  画三角形
 *
 *  @param ctx    图形上下文
 *  @param point  顶点
 *  @param length 边长
 *  @param color  绘制颜色
 */
- (void)drawTrangleWithContext:(CGContextRef)ctx topPoint:(CGPoint)point length:(CGFloat)length color:(UIColor *)color {
    CGMutablePathRef trianglePathM = CGPathCreateMutable();
    CGPathMoveToPoint(trianglePathM, NULL, point.x, point.y);
    CGPathAddLineToPoint(trianglePathM, NULL, point.x - length/2, point.y + length/2);
    CGPathAddLineToPoint(trianglePathM, NULL, point.x + length/2, point.y + length/2);
    CGContextAddPath(ctx, trianglePathM);
    [color set];
    CGContextFillPath(ctx);
    CGPathRelease(trianglePathM);
}

/*
 *  上下文旋转
 */
- (void)transFormCtx:(CGContextRef)ctx rect:(CGRect)rect {
    CGFloat translateXY = rect.size.width * .5f;
    //平移
    CGContextTranslateCTM(ctx, translateXY, translateXY);
    CGContextRotateCTM(ctx, self.angle);
    //再平移回来
    CGContextTranslateCTM(ctx, -translateXY, -translateXY);
}

#pragma mark - lazy
// 外环颜色
- (UIColor *)outCircleColor
{
    UIColor *color;
    switch (self.state) {
        case LPYCircleStateNormal:
            color = CircleStateNormalOutsideColor;
            break;
        case LPYCircleStateSelected:
            color = CircleStateSelectedOutsideColor;
            break;
        case LPYCircleStateError:
            color = CircleStateErrorOutsideColor;
            break;
        case LPYCircleStateLastOneSelected:
            color = CircleStateSelectedOutsideColor;
            break;
        case LPYCircleStateLastOneError:
            color = CircleStateErrorOutsideColor;
            break;
        default:
            color = CircleStateNormalOutsideColor;
            break;
    }
    return color;
}

// 实心圆颜色
- (UIColor *)inCircleColor
{
    UIColor *color;
    switch (self.state) {
        case LPYCircleStateNormal:
            color = CircleStateNormalInsideColor;
            break;
        case LPYCircleStateSelected:
            color = CircleStateSelectedInsideColor;
            break;
        case LPYCircleStateError:
            color = CircleStateErrorInsideColor;
            break;
        case LPYCircleStateLastOneSelected:
            color = CircleStateSelectedInsideColor;
            break;
        case LPYCircleStateLastOneError:
            color = CircleStateErrorInsideColor;
            break;
        default:
            color = CircleStateNormalInsideColor;
            break;
    }
    return color;
}

// 三角形颜色
- (UIColor *)trangleColor
{
    UIColor *color;
    switch (self.state) {
        case LPYCircleStateNormal:
            color = CircleStateNormalTrangleColor;
            break;
        case LPYCircleStateSelected:
            color = CircleStateSelectedTrangleColor;
            break;
        case LPYCircleStateError:
            color = CircleStateErrorTrangleColor;
            break;
        case LPYCircleStateLastOneSelected:
            color = CircleStateNormalTrangleColor;
            break;
        case LPYCircleStateLastOneError:
            color = CircleStateNormalTrangleColor;
            break;
        default:
            color = CircleStateNormalTrangleColor;
            break;
    }
    return color;
}

- (void)setAngle:(CGFloat)angle {
    _angle = angle;
    [self setNeedsDisplay];
}

- (void)setState:(LPYCircleState)state {
    _state = state;
    [self setNeedsDisplay];
}
@end
