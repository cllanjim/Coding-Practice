//
//  main.m
//  Liat 7-6
//
//  Created by 张思琦 on 15/6/11.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fraction.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool
    {
        Fraction *aFraction = [[Fraction alloc] init];
        Fraction *bFraction = [[Fraction alloc] init];
        
        Fraction *resultFraction;
        
        //设置1/4和1/2
        [aFraction setTo:1 over:4];
        [bFraction setTo:1 over:2];
        
        [aFraction print];
        NSLog(@"+");
        
        [bFraction print];
        NSLog(@"=");
        
        resultFraction = [aFraction add:bFraction];
        [resultFraction print];
        
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
