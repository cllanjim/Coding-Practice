//
//  MyButton.m
//  0827 事件处理案例2
//
//  Created by 张思琦 on 15/8/27.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "MyButton.h"

@implementation MyButton


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //获取UITouch对象
    UITouch *myTouch = [touches anyObject];
    
    //获取之前的位置
    CGPoint privLocation = [myTouch previousLocationInView:self.superview];
    //获取现在的位置
    CGPoint curLocation = [myTouch locationInView:self.superview];
    
    //计算偏移量
    CGFloat x = curLocation.x - privLocation.x;
    CGFloat y = curLocation.y - privLocation.y;
    
    //设置位移
    self.transform = CGAffineTransformTranslate(self.transform, x, y);
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    //转换point至btn的坐标系中
    CGPoint newPoint = [self convertPoint:point toView:self.btn];
    
    //判断
    if([self.btn pointInside:newPoint withEvent:event])
    {
        return self.btn;
    }else
    {
        return [super hitTest:point withEvent:event];
    }
    

}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
