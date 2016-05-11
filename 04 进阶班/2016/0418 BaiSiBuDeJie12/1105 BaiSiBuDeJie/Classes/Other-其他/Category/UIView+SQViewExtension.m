//
//  UIView+SQViewExtension.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 15/11/7.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "UIView+SQViewExtension.h"

@implementation UIView (SQViewExtension)
/**************************************************************************************************/
- (void)setSq_width:(CGFloat)sq_width
{
    CGRect frame = self.frame;
    frame.size.width = sq_width;
    self.frame = frame;
}

- (CGFloat)sq_width
{
    return self.frame.size.width;
}
/**************************************************************************************************/
- (CGFloat)sq_height
{
    return self.frame.size.height;
}

- (void)setSq_height:(CGFloat)sq_height
{
    CGRect frame = self.frame;
    frame.size.height = sq_height;
    self.frame = frame;
}
/**************************************************************************************************/
- (void)setSq_x:(CGFloat)sq_x
{
    CGRect frame = self.frame;
    frame.origin.x = sq_x;
    self.frame = frame;
}

- (CGFloat)sq_x
{
    return self.frame.origin.x;
}
/**************************************************************************************************/
- (void)setSq_y:(CGFloat)sq_y
{
    CGRect frame = self.frame;
    frame.origin.y = sq_y;
    self.frame = frame;
}

- (CGFloat)sq_y
{
    return self.frame.origin.y;
}
/**************************************************************************************************/
- (void)setSq_centerX:(CGFloat)sq_centerX
{
    CGPoint center = self.center;
    center.x = sq_centerX;
    self.center = center;
}

- (CGFloat)sq_centerX
{
    return self.center.x;
}
/**************************************************************************************************/
- (void)setSq_centerY:(CGFloat)sq_centerY
{
    CGPoint center = self.center;
    center.y = sq_centerY;
    self.center = center;
}
- (CGFloat)sq_centerY
{
    return self.center.y;
}
/**************************************************************************************************/
- (void)setSq_right:(CGFloat)sq_right
{
    self.sq_x = sq_right - self.sq_width;
}

- (CGFloat)sq_right
{
    return CGRectGetMaxX(self.frame);
}
/**************************************************************************************************/
- (void)setSq_bottom:(CGFloat)sq_bottom
{
    self.sq_y = sq_bottom - self.sq_height;
}

- (CGFloat)sq_bottom
{
    return CGRectGetMaxY(self.frame);
}


/**************************************************************************************************/

+ (instancetype)sq_viewFromXib{
    
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
    
}

- (BOOL)sq_intersectWithView:(UIView *)compareView{
    //获取keyWindow
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    //将selfView与compareView的frame转换到keyWindow上
    CGRect selfRect = [self.superview convertRect:self.frame toView:keyWindow];
    CGRect compareRect = [compareView.superview convertRect:compareView.frame toView:keyWindow];
    //判断两个控件是否有重叠
    return CGRectIntersectsRect(selfRect, compareRect);

}

- (BOOL)sq_intersectWithKeyWindow{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
 
    //将selfView的frame转换到keyWindow上
    CGRect selfRect = [self.superview convertRect:self.frame toView:keyWindow];
    CGRect keyWindowRect = [keyWindow.superview convertRect:keyWindow.frame toView:keyWindow];
    
    return CGRectIntersectsRect(selfRect, keyWindowRect);
}


@end
