//
//  main.m
//  List 6-2
//
//  Created by 张思琦 on 15/6/10.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

//----@interface部分
@interface Fraction : NSObject

-(void) print;
-(void) setNumerator: (int) n;
-(void) setDenominator: (int) d;
-(int) numerator;
-(int) denominator;
-(double) covertToNum;

@end

//-----@implementation部分
@implementation Fraction
{
    int numerator;
    int denominator;
}


-(void) print
{
    NSLog(@" %i / %i", numerator, denominator);
}

-(void) setNumerator: (int) n
{
    numerator = n;
}

-(void) setDenominator: (int) d;
{
    denominator = d;
}

-(int) numerator
{
    return numerator;
}

-(int) denominator
{
    return denominator;
}
-(double) covertToNum
{
    if(0 != denominator){
        return (double) numerator / denominator;
    }else
        return NAN;
}
@end



//----program部分
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        Fraction *aFraction = [[Fraction alloc] init];
        Fraction *bFraction = [[Fraction alloc] init];
        
        [aFraction setNumerator:1];
        [aFraction setDenominator:4];
        
        [aFraction print];
        NSLog(@" = ");
        NSLog(@"%g",[aFraction covertToNum]);
        
        [bFraction print];
        NSLog(@" = ");
        NSLog(@"%g",[bFraction covertToNum]);
     
        
        NSLog(@"Hello, World!");
    }
    return 0;
}
