//
//  UIImage+clipImageWithCircleShape.m
//  0113 图片剪裁
//
//  Created by 张思琦 on 16/1/13.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "UIImage+clipImageWithCircleShape.h"

@implementation UIImage (clipImageWithCircleShape)

+ (UIImage *)clipImage:(NSString *)imageName withCircleWidth:(CGFloat)width withCircleColor:(UIColor *)color{
    
    //1 获取图片
    UIImage *imageToUse = [UIImage imageNamed:imageName];
    
    //2 创建imageContext
    //设置边框宽度
    CGFloat circleWidth = width;
    //设置imageContext的size
    CGFloat contextWidth = imageToUse.size.width + 2 * circleWidth;
    //设置imageContext的CGRect
    CGRect contextRect = CGRectMake(0, 0, contextWidth, contextWidth);
    
    UIGraphicsBeginImageContextWithOptions(contextRect.size, NO, 0);
    
    //3 绘制外部的实心圆并填充颜色
    UIBezierPath *outterCirclePath = [UIBezierPath bezierPathWithOvalInRect:contextRect];
    //填充贝塞尔路径
    [color set];
    [outterCirclePath fill];
    
    //4 裁剪imageContext
    CGRect photoRect = CGRectMake(circleWidth, circleWidth, imageToUse.size.width, imageToUse.size.height);
    UIBezierPath *innerCirclePath = [UIBezierPath bezierPathWithOvalInRect:photoRect];
    [innerCirclePath addClip];
    
    //5 绘制图片至innerCircle
    [imageToUse drawAtPoint:CGPointMake(circleWidth, circleWidth)];
    
    //6 从上下文中获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //7 关闭上下文
    UIGraphicsEndImageContext();
    
    
    return image;
}


@end
