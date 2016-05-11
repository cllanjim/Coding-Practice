//
//  Fraction.m
//  Programming in Objective-C
//
//  Created by 张思琦 on 15/6/12.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "Fraction.h"

@implementation Fraction

@synthesize numerator, denominator;

- (void)setTo:(int)n over:(int)d
{
    numerator = n;//实例变量
    denominator = d;//
}

- (void)reduce
{
    int u = numerator;
    int v = denominator;
    int temp;
    
    while (0 != v) {
        temp = u % v;
        u = v;
        v = temp;
    }
    numerator /= u;
    denominator /= u;
    
}

- (double)convertToNum
{
    if (0 != denominator) {
        return (double) numerator / denominator;
    }else
        return NAN;
}

- (void)print
{
    NSLog(@"%i / %i ", numerator, denominator);
}

@end