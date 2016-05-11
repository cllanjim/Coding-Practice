//
//  main.m
//  List 11-1
//
//  Created by 张思琦 on 15/6/13.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "Fraction.h"

//方法私有化测试
//
//@interface Fraction()
//- (void)reduce;
//@end
//
//@implementation Fraction
//@synthesize numerator, denominator;
//
//- (void)setNumerator:(int)n andDen
//
//
//
//
//@end


//四种运算方法
//------@interface部分

@interface Fraction (MathOps)

- (Fraction *)add:(Fraction *)f;
- (Fraction *)mul:(Fraction *)f;
- (Fraction *)sub:(Fraction *)f;
- (Fraction *)div:(Fraction *)f;

@end


//------@implementation部分
@implementation Fraction (MathOps)

- (Fraction *)add:(Fraction *)f
{
    Fraction *result = [[Fraction alloc] init];
    
    result.numerator = (self.numerator * f.denominator) + (self.denominator * f.numerator);
    result.denominator = self.denominator * f.denominator;
    [result reduce];
    
    return result;
}

- (Fraction *)sub:(Fraction *)f
{
    Fraction *result = [[Fraction alloc] init];
    
    result.numerator = (self.numerator * f.denominator) - (self.denominator * f.numerator);
    result.denominator = self.denominator * f.denominator;
    [result reduce];
    
    return result;
}

- (Fraction *)mul:(Fraction *)f
{
    Fraction *result = [[Fraction alloc] init];
    
    result.numerator = self.numerator * f.numerator;
    result.denominator = self.denominator * f.denominator;
    [result reduce];
    
    return result;
}

- (Fraction *)div:(Fraction *)f
{
    Fraction *result = [[Fraction alloc] init];
    
    result.numerator = self.numerator * f.denominator;
    result.denominator = self.denominator * f.numerator;
    [result reduce];
    
    return result;
}

@end


//-----------Program部分

int main(int argc, char *argv[])
{
    @autoreleasepool {
        Fraction *a = [[Fraction alloc] init];
        Fraction *b = [[Fraction alloc] init];
        Fraction *result;
        [a setTo:1 over:3];
        [b setTo:2 over:5];
        
        [a print];
        NSLog(@"  +");
        [b print];
        NSLog(@"-------");
        result = [a add:b];
        [result print];
        NSLog(@"\n");
        
        [a print];
        NSLog(@"  +");
        [b print];
        NSLog(@"-------");
        result = [a sub:b];
        [result print];
        NSLog(@"\n");
        
        [a print];
        NSLog(@"  +");
        [b print];
        NSLog(@"-------");
        result = [a mul:b];
        [result print];
        NSLog(@"\n");
        
        [a print];
        NSLog(@"  +");
        [b print];
        NSLog(@"-------");
        result = [a div:b];
        [result print];
        NSLog(@"\n");
    }
    return 0;
}
