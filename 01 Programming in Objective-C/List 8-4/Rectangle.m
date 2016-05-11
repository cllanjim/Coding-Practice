//
//  Rectangle.m
//  Programming in Objective-C
//
//  Created by 张思琦 on 15/6/11.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "Rectangle.h"
#import "XYPoint.h"

@implementation Rectangle
{
    XYPoint *origin;
}

@synthesize width, height;


- (void)setWidth:(int)w andHeight:(int)h;
{
    width = w;
    height = h;
}

- (void)setOrigin:(XYPoint *)pt
{
    origin = pt;
}

- (int)area
{
    return  width * height;
}

- (int)perimeter;
{
    return (width + height) * 2;
}


- (XYPoint *)origin
{
    return origin;
}

@end

