//
//  DrawPath.m
//  0118 绘画板
//
//  Created by 张思琦 on 16/1/18.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "DrawPath.h"

@implementation DrawPath

+ (instancetype)drawPathWithLineColor:(UIColor *)color{
    DrawPath *path = [DrawPath bezierPath];
    path.lineColor = color;
    return path;

}

@end
