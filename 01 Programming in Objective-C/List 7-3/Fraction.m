//
//  Fraction.m
//  Programming in Objective-C
//
//  Created by 张思琦 on 15/6/11.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "Fraction.h"

@implementation Fraction
//{
//    int numerator;
//    int denominator;
//}

@synthesize numerator, denominator;


-(void) print
{
    NSLog(@"%i / %i", numerator, denominator);
}


-(double) convertToNum
{
    if(0 != denominator)
    {
        return (double) numerator / denominator;
    }else
        return NAN;
}

-(void) setTo:(int) n over:(int) b
{
    numerator = n;
    denominator = b;

}

//-(void) setNumerator: (int) n
//{
//    numerator = n;
//}
//
//-(void) setDenominator: (int) b
//{
//    denominator = b;
//}
//
//-(int) numerator
//{
//    return numerator;
//}
//
//-(int) denominator
//{
//    return denominator;
//}
@end