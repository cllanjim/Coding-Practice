//
//  Fraction.m
//  Programming in Objective-C
//
//  Created by 张思琦 on 15/6/11.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "Fraction.h"

@implementation Fraction

@synthesize numerator, denominator;

- (void)print
{
    NSLog(@"%i / %i", numerator, denominator);
}

- (double)convertToNum
{
    if(0 != denominator)
    {
        return (double) numerator / denominator;
    }else
        return NAN;
}

- (void)setTo:(int)n over:(int)b
{
    numerator = n;
    denominator = b;
}

- (void)add:(Fraction *)f
{
    numerator = numerator * f.denominator + denominator * f.numerator;
    denominator = denominator * f.denominator;
    [self reduce];
}

- (void)reduce
{
    int u = numerator;
    int v = denominator;
    int temp;
    
    while (0 != v)
    {
        temp = u % v;
        u = v;
        v = temp;
    }
    numerator /= u;
    denominator /= u;
}

@end
