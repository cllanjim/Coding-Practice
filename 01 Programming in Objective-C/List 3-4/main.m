//
//  main.m
//  List 3-4
//
//  Created by 张思琦 on 15/6/9.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//
#import <Foundation/Foundation.h>

//----@interface部分

@interface Fraction: NSObject

-(void) print;
-(void) setNumerator: (int) n;
-(void) setDenominator: (int) b;
-(int) numerator;
-(int) denominator;

@end


//----@implementation部分

@implementation Fraction
{
    int numerator;
    int denominator;
}

-(void) print
{
    NSLog(@"%i/%i", numerator, denominator);
}

-(void) setNumerator:(int)n
{
    numerator = n ;
}

-(void) setDenominator:(int)b
{
    denominator = b;
}

-(int) numerator
{
    return numerator;
}
          
-(int) denominator
{
    return denominator;
}
          
@end

//----program部分

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        Fraction *myFraction =[[Fraction alloc] init];
        
        [myFraction setNumerator:1];
        [myFraction setDenominator:3];
        
        NSLog(@"The value of myFraction is %i/%i",[myFraction numerator],[myFraction denominator]);
        
        
        
        NSLog(@"Hello, World!");
    }
    return 0;
}
