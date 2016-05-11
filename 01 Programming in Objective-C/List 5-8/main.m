//
//  main.m
//  List 5-8
//
//  Created by 张思琦 on 15/6/10.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//


//颠倒数字顺序
#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int number, right_digit;
        
        NSLog(@"Enter you Number:");
        scanf("%i",&number);
        
        while (0 != number){
            right_digit = number % 10;
            NSLog(@"%i",right_digit);
            number /=10;
        }
        
        
        
        NSLog(@"Hello, World!");
    }
    return 0;
}
