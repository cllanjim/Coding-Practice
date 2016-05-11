//
//  main.m
//  List 4-6
//
//  Created by 张思琦 on 15/6/10.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

//实现Calculator类

#import <Foundation/Foundation.h>

@interface Calculator : NSObject

//累加方法
-(void) setAccumulator: (double) value;
-(void) clear;
-(double) accumulator;

//算术方法
-(void) add: (double) value;
-(void) subtract: (double) value;
-(void) multiply: (double) value;
-(void) divide: (double) value;

@end

@implementation Calculator
{
    double accumulator;
}

//累加方法
-(void) setAccumulator: (double) value
{
    accumulator = value;
}

-(void) clear
{
    accumulator = 0;
}

-(double) accumulator
{
    return accumulator;
}


//算术方法
-(void) add: (double) value
{
    accumulator += value;
}

-(void) subtract: (double) value
{
    accumulator -= value;
}

-(void) multiply: (double) value;
{
    accumulator *= value;
}

-(void) divide: (double) value;
{
    accumulator /= value;
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        Calculator * deskCalc = [[Calculator alloc] init];
        
        [deskCalc setAccumulator:100];
        [deskCalc add:200];
        [deskCalc divide:15.0];
        [deskCalc subtract:10.0];
        [deskCalc multiply:5];
        
        NSLog(@"The result is %g", [deskCalc accumulator]);
        
        
        NSLog(@"Hello, World!");
    }
    return 0;
}
