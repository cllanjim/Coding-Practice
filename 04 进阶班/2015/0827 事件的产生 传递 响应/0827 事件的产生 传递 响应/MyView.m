//
//  MyView.m
//  0827 事件的产生 传递 响应
//
//  Created by 张思琦 on 15/8/27.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "MyView.h"

@implementation MyView



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    NSLog(@"%@",self);

}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    
    //移动自身
    
    //方法一
    //缺点 在开始拖动的时候会直接改变view的位置
    //获取UITouch对象
//    UITouch *myTouch = [touches anyObject];
//    //获取当前的位置
//    CGPoint myPoint = [myTouch locationInView:[self superview]];
//    //重新设定位置
//    CGRect newFrame = self.frame;
//    newFrame.origin = myPoint;
//    self.frame = newFrame;
    
    //方法二
    
    UITouch *myTouch = [touches anyObject];
    //获取之前的坐标位置
    CGPoint prevLocation = [myTouch previousLocationInView:[self superview]];
    
    //获取当前的坐标位置
    CGPoint curLocation = [myTouch locationInView:[self superview]];
    //计算手指的移动距离
    self.transform = CGAffineTransformTranslate(self.superview.transform, curLocation.x - prevLocation.x, curLocation.y - prevLocation.y);
    
    
    
    
    
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
