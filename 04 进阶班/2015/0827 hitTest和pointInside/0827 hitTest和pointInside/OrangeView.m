//
//  OrangeView.m
//  0827 hitTest和pointInside
//
//  Created by 张思琦 on 15/8/27.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "OrangeView.h"

@implementation OrangeView


//用于选取调用者范围内最合适处理事件的视图控件
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    NSLog(@"%@", self);
    
    return [super hitTest:point withEvent:event];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@", [self class]);

}









/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
