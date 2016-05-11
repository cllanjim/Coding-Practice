//
//  Fraction.m
//  Programming in Objective-C
//
//  Created by 张思琦 on 15/6/12.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "Fraction.h"

static int gCounter;

@implementation Fraction

@synthesize numerator, denominator;

+ (Fraction *)allocF
{
    //extern int gCounter;
    int gCounter;
    ++gCounter;
    
    return [Fraction alloc];
}

+ (int)count
{
    //extern int gCounter;
    int gCounter;
    return gCounter;
}

- (Fraction *)init
{
    return [self initWith:0 over:0];
}

- (void)print
{
    NSLog(@"%i / %i ", numerator, denominator);
}

- (double)convertToNum
{
    if (0 != denominator) {
        return (double) numerator / denominator;
    }else
        return NAN;
}

- (void)setTo:(int)n over:(int)d
{
    numerator = n;
    denominator = d;
}

- (Fraction *)add:(Fraction *)f
{
    Fraction *result = [[Fraction alloc] init];
    result.numerator = numerator * f.denominator + denominator * f.numerator;
    result.denominator = denominator * f.denominator;
    [result reduce];
    return result;
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

- (Fraction *)initWith:(int)n over:(int)d
{
    self = [super init];
    
    if (self)
    {
        [self setTo:n over:d];
        
    }
    return self;

}

@end