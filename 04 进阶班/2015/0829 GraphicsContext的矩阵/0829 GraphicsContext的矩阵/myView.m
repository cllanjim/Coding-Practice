//
//  myView.m
//  0829 GraphicsContext的矩阵
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
    //1.获取当前GraphicsContext
    CGContextRef context = UIGraphicsGetCurrentContext();
    //2.设置BezierPath路径
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 50, 100, 50)];
    [[UIColor redColor] set];
    
    //对path图形做移动
    //CGContextTranslateCTM(CGContextRef c, CGFloat tx, CGFloat ty)
    //CGContextRef c    代表要操作的上下文
    //CGFloat tx        x轴移动方向
    //CGFloat ty        y轴移动方向
    CGContextTranslateCTM(context, 50, 50);
    
    
    //对path图形做转动
    //CGContextRef c    代表要操作的GraphicsContext
    //CGFloat angle     代表要旋转的角度
    CGContextRotateCTM(context,  M_PI_4);
    
    
    //对path图形做缩放
    //CGContextRef c    代表要操作的GraphicsContext
    //CGFloat sx        代表x轴上的缩放系数
    //CGFloat sy        代表y轴上的缩放系数
    CGContextScaleCTM(context, 1.2, 1.2);
    
    
    [path fill];
    


}


@end
