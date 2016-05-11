//
//  main.m
//  List 5-3
//
//  Created by 张思琦 on 15/6/10.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        int n, triangularNumber;
        
        
        NSLog(@"TABLE of TRIANGULAR NUMBERS");
        NSLog(@" n     sum from 1 to n");
        NSLog(@"---    ---------------");
        
        
        triangularNumber = 0;
        
        for (n =1; n <= 10; ++n )
        {
            triangularNumber += n;
        NSLog(@"%03i    %03i", n, triangularNumber);
        }
        
        NSLog(@"Hello, World!");
    }
    return 0;
}
