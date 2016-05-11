//
//  WheelButton.m
//  0121 转盘
//
//  Created by 张思琦 on 16/1/22.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "WheelButton.h"

@implementation WheelButton

#pragma mark - 重新设的image的位置
//- (CGRect)imageRectForContentRect:(CGRect)contentRect{
//    CGFloat imageW = 40;
//    CGFloat imageH = 47;
//    CGFloat imageX = (self.bounds.size.width - imageW) * 0.5;
//    CGFloat imageY = 20;
//    
//    return CGRectMake(imageX, imageY, imageW, imageH);
//}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat imageW = 40;
    CGFloat imageH = 47;
    CGFloat imageX = (self.bounds.size.width - imageW) * 0.5;
    CGFloat imageY = 20;
    CGRect rect = CGRectMake(imageX, imageY, imageW, imageH);
    
    self.imageView.frame = rect;
    
}

#pragma mark - 设定触摸区域
//通过设定响应区域来
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    //设定响应区域
    CGRect hitRect = CGRectMake(0, 0, self.bounds.size.width, 47);
    //如果触摸点不在响应区域内,就不做处理
    if (CGRectContainsPoint(hitRect, point) == NO) {
        return nil;
    }
    return [super hitTest:point withEvent:event];
}

#pragma mark - 取消点击后的highlighted的默认实现方式
- (void)setHighlighted:(BOOL)highlighted{
    //do nothing
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
