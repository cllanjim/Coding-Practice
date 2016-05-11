//
//  personalView.m
//  0828 Quartz2D的基本使用
//
//  Created by 张思琦 on 15/8/28.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "personalView.h"


@implementation personalView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.




- (void)drawRect:(CGRect)rect {

    //1.获取当前view的Graphics Context
    //CGContextRef本质是指向CGContext结构体的指针,不是一个对象!!!
    //typedef struct CGContext *CGContextRef;
    CGContextRef graphicsContext = UIGraphicsGetCurrentContext();
    
    //2.生成贝塞尔曲线
    UIBezierPath *path = [UIBezierPath bezierPath];
    //2.1 设置起点
    [path moveToPoint:CGPointMake(10, 10)];
    //2.2 设置重点
    [path addLineToPoint:CGPointMake(170, 170)];
    
    [path addLineToPoint:CGPointMake(10, 170)];
    
    //3. 渲染path路径至view上
    [path stroke];
    
    //3.将绘制内容添加到Graphics Context中
    //这是一个函数!!!
    CGContextAddPath(graphicsContext, path.CGPath);
    
    //设置曲线的属性
    //设置线段宽度
    CGContextSetLineWidth(graphicsContext, 10);
    
    //设置线段顶端的样式
    //kCGLineCapButt：该属性值指定不绘制端点，线条结尾处直接结束。这是默认值。
    //kCGLineCapRound：该属性值指定绘制圆形端点，线条结尾处绘制一个直径为线条宽度的半圆。
    //kCGLineCapSquare：该属性值指定绘制方形端点。线条结尾处绘制半个边长为线条宽度的正方形。
    //需要说明的是，这种形状的端点与“butt”形状的端点十分相似，只是采用这种形式的端点的线条略长一点而已
    CGContextSetLineCap(graphicsContext, kCGLineCapButt);
    
    //设置两条线段衔接处的样式
    //kCGLineJoinMiter, 尖角
    //kCGLineJoinRound, 圆角
    //kCGLineJoinBevel, 平角
    CGContextSetLineJoin(graphicsContext, kCGLineJoinBevel);
    
    
    
    //4.将Graphics Context渲染到view上
    //这是一个函数!!!
    CGContextStrokePath(graphicsContext);
    
}


@end
