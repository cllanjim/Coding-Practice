//
//  pieChartView.m
//  1228 绘制饼图
//
//  Created by 张思琦 on 15/12/28.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "pieChartView.h"

@implementation pieChartView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self setNeedsDisplay];
    
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    NSLog(@"%s",__func__);
    NSArray *array = @[@25,@25,@50];
    CGPoint center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    CGFloat radius = self.bounds.size.width * 0.5 - 4;
    CGFloat startAngle = 0;
    CGFloat endAngle = 0;
    CGFloat angle = 0;
    
    for (NSNumber *valueString in array) {
        //将NSNumber转换为NSInteger对象
        NSInteger value = [valueString integerValue];
        //将value计算成弧度值
        angle = (value / 100.0) * M_PI * 2;
        //计算终点角度
        endAngle += angle;
        //绘制UIBezierPath曲线
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
        //绘制弧线终点到圆心的直线
        [path addLineToPoint:center];
        //设置颜色
        [[self randomColor] set];
        //填充弧线区域
        [path fill];
        //刷新起始角度
        startAngle = endAngle;
    }
}

- (UIColor *)randomColor{
    CGFloat r = arc4random_uniform(256)/255.0;
    CGFloat g = arc4random_uniform(256)/255.0;
    CGFloat b = arc4random_uniform(256)/255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}


@end
