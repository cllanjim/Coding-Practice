//
//  main.m
//  List 6-3
//
//  Created by 张思琦 on 15/6/10.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        int number_to_test, remainder;
        
        NSLog(@"Enter your number to be tested:");
        scanf("%i", &number_to_test);
        
        remainder = number_to_test % 2;
        
        if ( 0 == remainder)
            NSLog(@"The number is even");
        if ( 0 != remainder)
            NSLog(@"The number is odd");

        
        NSLog(@"Hello, World!");
    }
    return 0;
}
