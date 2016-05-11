//
//  main.m
//  List 9-1
//
//  Created by 张思琦 on 15/6/11.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Complex.h"
#import "Fraction.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Fraction *f1 = [[Fraction alloc] init];
        Fraction *f2 = [[Fraction alloc] init];
        Fraction *fracResult;
        
        Complex *c1 = [[Complex alloc] init];
        Complex *c2 = [[Complex alloc] init];
        Complex *compResult;
        
        //设置两个分数,一个为1/10,一个为2/15
        [f1 setTo:1 over:10];
        [f2 setTo:2 over:15];
        
        //设置两个数
        [c1 setReal:18.0 andImainary:2.5];
        [c2 setReal:-5.0 andImainary:3.2];
        
        //将两个complex相加
        [c1 print];
        NSLog(@"         +");
        [c2 print];
        NSLog(@"----------");
        compResult = [c1 add:c2];
        [compResult print];
        NSLog(@"\n");
        
        [f1 print];
         NSLog(@"         +");
         [f2 print];
         NSLog(@"----------");
         fracResult = [f1 add:f2];
         [fracResult print];
         NSLog(@"\n");
        
        
        
        NSLog(@"Hello, World!");
    }
    return 0;
}
