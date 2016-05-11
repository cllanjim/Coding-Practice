//
//  Complex.m
//  Programming in Objective-C
//
//  Created by 张思琦 on 15/6/12.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "Complex.h"

@implementation Complex

@synthesize real, imaginary;

- (void) print
{
    NSLog(@" %g + %gi", real, imaginary);
}

- (void) setReal:(double)a andImainary:(double)b
{
    real = a;
    imaginary = b;
    
}

- (Complex *)add:(Complex *)f
{
    Complex *result = [[Complex alloc] init];
    
    result.real = real + f.real;
    result.imaginary = imaginary + f.imaginary;
    
    return result;
}

@end
