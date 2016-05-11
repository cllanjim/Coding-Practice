//
//  progressView.m
//  1227 重绘下载进度
//
//  Created by 张思琦 on 15/12/27.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "progressView.h"

@implementation progressView

- (void)setProgressValue:(CGFloat)progressValue{
    _progressValue = progressValue;
    //不能直接调用- (void)drawRect:(CGRect)rect方法
    //1该方法系统只调用一次，无法持续更新
    //2用户使用该方法时 ，无法像系统一样将图形上下文传入到方法中
    //解决方案：如果需要更新view需要调用setNeedsDisplay
    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    //Quartz2D 属于 Core Graphics框架
    
    //1 绘制相应的图画内容
    //设定center
    CGPoint center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    //设定radius
    CGFloat radius = self.bounds.size.height * 0.5 - 4;
    //设置终点
    CGFloat startAngle = - M_PI_2;
    CGFloat endAngle = - M_PI_2 + 2 * M_PI * self.progressValue;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    
    
    //2 将绘制内容渲染到view上
    [path stroke];
   
    
    /*
    //1 获取当前view的上下文内容
    CGContextRef content = UIGraphicsGetCurrentContext();
    //2 在上下文中绘制图形
    //设定center
    CGPoint center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    //设定radius
    CGFloat radius = self.bounds.size.height * 0.5 - 4;
    //设置起点,终点
    CGFloat startAngle = - M_PI_2;
    CGFloat endAngle = - M_PI_2 + 2 * M_PI * self.progressValue;

//    CG_EXTERN void CGContextAddArc(CGContextRef __nullable c, CGFloat x, CGFloat y, CGFloat radius, CGFloat startAngle, CGFloat endAngle, int clockwise)
//    CGContextAddArc(content, center.x, center.y, radius, endAngle, startAngle, YES);
    CGContextAddArc(content, center.x, center.y, radius, startAngle , endAngle, NO);

    //将上下文渲染到View上
    CGContextStrokePath(content);
    */
}

@end
