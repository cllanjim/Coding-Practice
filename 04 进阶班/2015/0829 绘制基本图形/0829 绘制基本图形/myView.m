//
//  myView.m
//  0829 绘制基本图形
//
//  Created by 张思琦 on 15/8/29.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "myView.h"

@implementation myView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect {
// Drawing code

    //绘制矩形
    //1. 生成UIBezierPath对象
    //UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(10, 10, 150, 150)];
    //2. 绘制矩形
    //[path stroke];

    //绘制椭圆
    //1.生成UIBezierPath对象
    //UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(10, 10, 100, 50)];
    //2.绘制椭圆
    //[path stroke];

    //绘制圆弧
    //center: 圆心
    //radius: 半径
    //startAngle: 起始点
    //endAngle: 终点
    //clockwise: YES 顺时针 NO 逆时针
    //1.生成UIBezierPath对象
    //CGPoint center = CGPointMake(100, 100);
    //UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:50 startAngle:0 endAngle:M_PI_2 clockwise:YES];
    //2.绘制圆弧
    //[path stroke];
    
    
    //绘制扇形
    //1.生成UIBeizerPath对象
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100) radius:50 startAngle:0 endAngle:M_PI_2 clockwise:YES];
    //2.封闭图形
    //closePath方法会将线段的起点和终点相连封闭图形
    [path closePath];
    //3.绘制扇形
    //设置颜色
    //会根据最后根据的方法决定是描边还是填充整个图案
    [[UIColor redColor] set];
    //填充整个图案
    [[UIColor yellowColor] setFill];
    //将整个图案描边
    [[UIColor greenColor] setStroke];
    //将图案填充并渲染
    [path fill];
    //将图案描边并渲染
    [path stroke];
    
    


}


@end
