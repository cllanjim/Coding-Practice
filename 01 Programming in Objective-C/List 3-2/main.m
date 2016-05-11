//
//  main.m
//  List 3-2
//
//  Created by 张思琦 on 15/6/8.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//


//使用分数的程序
#import <Foundation/Foundation.h>

//----@interface部分----

@interface Fraction : NSObject

-(void) print;
-(void) setNumerator: (int) n;
-(void) setDenominator: (int) d;

@end

//----@implementation部分----
@implementation Fraction
{
    int numerator;
    int denominator;
}

-(void) print
{
    NSLog(@"%i/%i",numerator,denominator);
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


//----program----

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Fraction *myFraction;
        
        //创建一个分数实例
        
        myFraction = [Fraction alloc];
        myFraction = [myFraction init];
        
        //设置分数为1/3
        [myFraction setNumerator: 1];
        [myFraction setDenominator:3];
        
        //使用打印方法显示分数
        
        NSLog(@"The value of myFraction is :");
        [myFraction print];
        
        NSLog(@"Hello, World!");
    }
    return 0;
}
