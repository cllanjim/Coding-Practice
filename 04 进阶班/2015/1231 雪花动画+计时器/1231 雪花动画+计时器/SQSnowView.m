//
//  SQSnowView.m
//  1231 雪花动画+计时器
//
//  Created by 张思琦 on 15/12/31.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "SQSnowView.h"

@implementation SQSnowView

//生成一个静态全局变量
static CGFloat snowY = 0;

//因为view已经出现在main.storyboard中，所以可以使用awakeFromNib进行加载
- (void)awakeFromNib{
    //方式一 使用NSTimer
    //NSInvocation本质也是包装了一个方法的对象

    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(setNeedsDisplay) userInfo:nil repeats:YES];

    //方式二
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(setNeedsDisplay)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];

}

- (void)drawRect:(CGRect)rect {
    //绘制雪花
    UIImage *image = [UIImage imageNamed:@"雪花"];
    [image drawAtPoint:CGPointMake(30, snowY)];
    //每次加载后移动绘制的Y坐标
    snowY += 10;
    //如果移出屏幕就将雪花的Y坐标归零
    if (snowY > self.bounds.size.height) {
        snowY = 0;
    }
    
}

@end
