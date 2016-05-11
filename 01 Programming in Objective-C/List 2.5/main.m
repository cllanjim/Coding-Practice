//
//  main.m
//  List 2.5
//
//  Created by 张思琦 on 15/6/8.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int value1, value2, sum;
        
        value1 = 50;
        value2 = 25;
        sum = value1 + value2;
        
        NSLog(@"The sum of %i and %i is %i", value1, value2, sum);
        NSLog(@"Hello, World!");
    }
    return 0;
}
