//
//  main.m
//  List 4-2
//
//  Created by 张思琦 on 15/6/10.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
       
        int a = 100;
        int b = 2;
        int c = 25;
        int d = 4;
        int result;
        
        result = a - b; //减法
        NSLog(@"a - b = %i", result);
        
        result = b * c; //乘法
        NSLog(@"b * c = %i", result);
        
        result = a / c; //除法
        NSLog(@"a / c = %i", result);
        
        result = a + b * c; //优先级
        NSLog(@"a * b + c * d = %i", a * b + c * d);        NSLog(@"Hello, World!");
    }
    return 0;
}
