//
//  NSObject+MathMethod.h
//  0127 粘性效果
//
//  Created by 张思琦 on 16/1/28.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NSObject (MathMethod)
//计算两个圆心的距离
- (CGFloat)centerDistanceBetweenCurrentViewCenter:(CGPoint)currentViewCenter andOriginalViewCenter:(CGPoint)originalViewCenter;


- (UIBezierPath *)pathWithOriginalViewCenter:(CGPoint)center originalViewRadius:(CGFloat)radius andCurrentViewCenter:(CGPoint)center currentViewRadius:(CGFloat)radius;

@end
