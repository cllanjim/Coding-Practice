//
//  SQDrawView.m
//  0105 图形上下文栈
//
//  Created by 张思琦 on 16/1/5.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "SQDrawView.h"

@implementation SQDrawView


//画两个不同的线

- (void)drawRect:(CGRect)rect {
    // Drawing code
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //保存原始状态
    CGContextSaveGState(context);
    {//绘制内容
        //绘制第一条直线
        CGContextMoveToPoint(context, 150, 60);
        CGContextAddLineToPoint(context, 150, 200);
        //设置第一条直线的上下文的属性值
        CGContextSetLineWidth(context, 5);
        CGContextSetLineCap(context, kCGLineCapRound);
        [[UIColor redColor] set];
        CGContextStrokePath(context);
    }
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    {//绘制内容
        //绘制第二条直线
        CGContextMoveToPoint(context, 30, 150);
        CGContextAddLineToPoint(context, 300, 150);
        [[UIColor greenColor] set];
        CGContextStrokePath(context);
    }
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    {//绘制内容
        //绘制第二条直线
        CGContextMoveToPoint(context, 30, 350);
        CGContextAddLineToPoint(context, 300, 350);
        [[UIColor blueColor] set];
        CGContextStrokePath(context);
    }
    CGContextRestoreGState(context);
    
    CGContextMoveToPoint(context, 30, 400);
    CGContextAddLineToPoint(context, 300, 350);
    CGContextStrokePath(context);
    

}


@end
