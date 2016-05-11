//
//  main.m
//  List 7-5
//
//  Created by 张思琦 on 15/6/11.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fraction.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Fraction *aFraction = [[Fraction alloc] init];
        Fraction *bFraction = [[Fraction alloc] init];
        
        //设置两个对象分别为1/2和1/4
        
        [aFraction setTo:1 over:2];
        [bFraction setTo:1 over:4];
        
        //打印结果
        [aFraction print];
        NSLog(@"+");
        
        [bFraction print];
        NSLog(@"=");
        
        [aFraction add:bFraction];
        //[aFraction reduce];
        [aFraction print];
        
        
        NSLog(@"Hello, World!");
    }
    return 0;
}
