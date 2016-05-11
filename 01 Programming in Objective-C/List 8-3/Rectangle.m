//
//  Rectangle.m
//  Programming in Objective-C
//
//  Created by 张思琦 on 15/6/11.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "Rectangle.h"

@implementation Rectangle

@synthesize width, height;


- (void)setWidth:(int)w andHeight:(int)h;
{
    width = w;
    height = h;
}

- (int)area
{
    return  width * height;
}

- (int)perimeter;
{
    return (width + height) * 2;
}

@end

