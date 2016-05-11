//
//  DrawView.m
//  0126 粒子效果
//
//  Created by 张思琦 on 16/1/26.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "DrawView.h"

@interface DrawView ()

@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, strong) CALayer *greenLayer;


@end

@implementation DrawView

- (UIBezierPath *)path{
    if (_path == nil) {
        _path = [UIBezierPath bezierPath];
    }
    return _path;
}

- (CALayer *)greenLayer{
    if (_greenLayer == nil) {
        //创建复制层
        CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
        replicatorLayer.frame = self.bounds;
        
        replicatorLayer.instanceCount = 10;
        replicatorLayer.instanceDelay = 0.2;
        [self.layer addSublayer:replicatorLayer];
        
        //创建greenLayer
        CALayer *greenLayer = [CALayer layer];
        greenLayer.frame = CGRectMake(0, 0, 10, 10);
        greenLayer.backgroundColor = [UIColor greenColor].CGColor;
        greenLayer.cornerRadius = 5;
        _greenLayer = greenLayer;
        
        [replicatorLayer addSublayer:greenLayer];
    }
    return _greenLayer;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //获取当前触摸点坐标
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    
    //记录路径的起点
    [self.path moveToPoint:currentPoint];
    
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //获取当前触摸点坐标
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    //绘制路径经过的点
    [self.path addLineToPoint:currentPoint];
    
    [self setNeedsDisplay];
    
}


- (void)startAnimation{
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"position";
    anim.path = self.path.CGPath;
    anim.duration = 2;
    anim.repeatCount = MAXFLOAT;
    [self.greenLayer addAnimation:anim forKey:nil];
    
}


- (void)clearAnimation{
    [self.path removeAllPoints];
    [self setNeedsDisplay];
    
    [self.greenLayer removeAllAnimations];
    
    
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self.path stroke];
    
    
}


@end
