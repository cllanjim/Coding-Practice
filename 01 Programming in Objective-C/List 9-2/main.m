//
//  main.m
//  List 9-2
//
//  Created by 张思琦 on 15/6/12.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fraction.h"
#import "Complex.h"


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        id dataValue;
        Fraction *f1 = [[Fraction alloc] init];
        Complex *c1 = [[Complex alloc] init];
        
        [f1 setTo:2 over:5];
        [c1 setReal:10.0 andImainary:2.5];
        
        //第一个dataValue获得了一个分数
        
        dataValue = f1;
        [dataValue print];
        
        //第一个dateValue获得一个Complex数
        
        dataValue = c1;
        [dataValue print];
        
        //Fraction类
        id dataValue1;;
        [dataValue1 setTo:2 over:5];
        //Complex类
        id dataValue2;
        [dataValue2 setReal:10.0 andImainary:3.5];
        
        Fraction *result = [[Fraction alloc] init];
        [result print];

        result = [dataValue1 add:dataValue2];
        NSLog(@"-------------");

        [result print];
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
