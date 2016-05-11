//
//  NSObject+MathMethod.m
//  0127 粘性效果
//
//  Created by 张思琦 on 16/1/28.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "NSObject+MathMethod.h"

@implementation NSObject (MathMethod)

- (CGFloat)centerDistanceBetweenCurrentViewCenter:(CGPoint)currentViewCenter andOriginalViewCenter:(CGPoint)originalViewCenter{
   
    CGFloat x = currentViewCenter.x - originalViewCenter.x;

    CGFloat y = currentViewCenter.y - originalViewCenter.y;
    //通过勾股定理计算两点之间的距离
    return sqrtf(x * x + y * y);
}


//计算两个圆围成的区域
- (UIBezierPath *)pathWithOriginalViewCenter:(CGPoint)originalCenter originalViewRadius:(CGFloat)originalRadius andCurrentViewCenter:(CGPoint)currentCenter currentViewRadius:(CGFloat)currentRadius
{
    // 获取小圆x1和y1
    CGFloat x1 = originalCenter.x;
    CGFloat y1 = originalCenter.y;
    
    // 获取小圆x2和y2
    CGFloat x2 = currentCenter.x;
    CGFloat y2 = currentCenter.y;
    
    // 获取圆心距离
    CGFloat d = [self centerDistanceBetweenCurrentViewCenter:currentCenter andOriginalViewCenter:originalCenter];
    
    // sinθ
    CGFloat sinθ = (x2 - x1) / d;
    
    // cosθ
    CGFloat cosθ = (y2 - y1) / d;
    
    
    CGFloat r1 = originalRadius ;
    
    CGFloat r2 = currentRadius;
    
    // A点
    CGPoint pointA = CGPointMake(x1 - r1 * cosθ, y1 + r1 * sinθ);
    // B点
    CGPoint pointB = CGPointMake(x1 + r1 * cosθ, y1 - r1 * sinθ);
    // C点
    CGPoint pointC = CGPointMake(x2 + r2 * cosθ, y2 - r2 * sinθ);
    // D点
    CGPoint pointD = CGPointMake(x2 - r2 * cosθ, y2 + r2 * sinθ);
    
    // 控制点
    // O点
    CGPoint pointO = CGPointMake(pointA.x + d * 0.5 * sinθ, pointA.y + d * 0.5 * cosθ);
    // P点
    CGPoint pointP = CGPointMake(pointB.x + d * 0.5 * sinθ, pointB.y + d * 0.5 * cosθ);
    
    
    //创建路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:pointA];
    
    [path addLineToPoint:pointB];
    
    [path addQuadCurveToPoint:pointC controlPoint:pointP];
    
    [path addLineToPoint:pointD];
    
    [path addQuadCurveToPoint:pointA controlPoint:pointO];
    
    return path;
    
    
}


@end
