//
//  main.m
//  List 7-1
//
//  Created by 张思琦 on 15/6/11.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "Fraction.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Fraction *myFraction = [[Fraction alloc] init];
        
        //设置分数为1/3
        
        [myFraction setNumerator: 1];
        [myFraction setDenominator: 3];

        
        //显示分数
        NSLog(@"The value of myFraction is:");
        [myFraction print];
        
        NSLog(@"Hello, World!");
    }
    return 0;
}
