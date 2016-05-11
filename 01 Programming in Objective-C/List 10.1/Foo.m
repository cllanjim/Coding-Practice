//
//  Foo.m
//  Programming in Objective-C
//
//  Created by 张思琦 on 15/6/13.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "Foo.h"

@implementation Foo

- (void)setgGlobalVal:(int)val
{
    extern int gGlobalVar;
    gGlobalVar = val;
}

@end

