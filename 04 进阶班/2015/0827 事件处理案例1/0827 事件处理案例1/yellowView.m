//
//  yellowView.m
//  0827 事件处理案例1
//
//  Created by 张思琦 on 15/8/27.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "yellowView.h"

@interface yellowView  ()

@property (nonatomic, weak) IBOutlet UIButton *pinkButton;

@end

@implementation yellowView



- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    //转换point的坐标系为self.pinkButton
   CGPoint newPoint = [self convertPoint:point toView:self.pinkButton];
    //判断当前点是否在button的范围中
    if ([self.pinkButton pointInside:newPoint withEvent:event]) {
        return self.pinkButton;
    }else{
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
