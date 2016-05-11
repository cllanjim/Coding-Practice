//
//  main.m
//  List 7-2
//
//  Created by 张思琦 on 15/6/11.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fraction.h"


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Fraction *myFraction =[[Fraction alloc] init];
        
        //将分数设置为1/3
        
        myFraction.numerator = 1;
        myFraction.denominator = 3;
        
        //显示分数
        
        NSLog(@"The numerator is %i, and the denominator is %i ", myFraction.numerator, myFraction.denominator);
        
        
        NSLog(@"Hello, World!");
    }
    return 0;
}
