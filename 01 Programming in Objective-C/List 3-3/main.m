//
//  main.m
//  List 3-3
//
//  Created by 张思琦 on 15/6/9.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

//----@interface部分-----

@interface Fraction : NSObject

-(void) print;
-(void) setNumerator: (int) n;
-(void) setDenominator: (int) n;

@end

//----@implementation

@implementation Fraction
{
    int numerator;
    int denominator;
}

-(void) print
{
    NSLog(@"%i/%i", numerator, denominator);
}

-(void) setNumerator: (int) n
{
    numerator = n;
}

-(void) setDenominator: (int) d
{
    denominator = d;
}

@end

//-----program部分----


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Fraction *frac1 = [[Fraction alloc] init];
        Fraction *frac2 = [[Fraction alloc] init];
        
        //设置第一个分数为2/3
        [frac1 setNumerator:2];
        [frac1 setDenominator:3];
        
        //设置第二个分数为3/7
        [frac2 setNumerator:3];
        [frac2 setDenominator:7];
        
        //显示分数
        NSLog(@"First fraction is:");
        
        [frac1 print];
        
        NSLog(@"Second fraction is:");
        
        [frac2 print];
        
        NSLog(@"Hello, World!");
    }
    return 0;
}
