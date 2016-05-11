//
//  WhiteView.m
//  0827 hitTest和pointInside
//
//  Created by 张思琦 on 15/8/27.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "WhiteView.h"

@implementation WhiteView


//用于选取调用者范围内最合适处理事件的视图控件
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    NSLog(@"%@", self);
//    
//   return [super hitTest:point withEvent:event];
//}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    //1 判断当前view是否能处理触摸事件,
    // 交互功能属性 隐藏属性 透明度属性
    //如果满足以上任意一个条件,就返回nil
    //如果都不满足,就往下执行代码
    if (self.userInteractionEnabled == NO || self.hidden == YES || self.alpha <= 0.01 ){
        return nil;
    }
    
    //2 判断point是否在当前view的范围内
    //如果传入的point不在当前view中,就返回nil
    //如果传入的point在当前view中,就继续执行代码
    if ([self pointInside:point withEvent:event] == NO  ) {
        return nil;
    }
    
    //3 从后往前遍历当前view中的子控件,寻找是否有更合适的view
    //获取子控件数量
    int count = (int)self.subviews.count;
    //从后往前遍历子控件
    for (int i = count - 1 ; i >= 0; i--) {
        //从后获取第i个子控件
        UIView *childView = self.subviews[i];
        //转换传入的point的坐标系
        CGPoint newPoint = [self convertPoint:point toView:childView];
        //获取在childView中处理newPoint点的最合适view
        UIView *bestView = [childView hitTest:newPoint withEvent:event];
        //判断拿到的view是否为空,如果不空就返回该view
        if (bestView) {
            return bestView;
        }
    }
    
    //4 如果以上条件都不符合,就返回自身
    return self;

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
