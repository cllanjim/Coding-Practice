//
//  main.m
//  List 13-4
//
//  Created by 张思琦 on 15/6/15.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

void calculateTriangularNumber(int n)
{
    int i, triangularNumber = 0;
    
    for (i = 0; i <= n ; ++i) {
        triangularNumber += i;
    }
    
    NSLog(@"Triangular number %i is %i", n, triangularNumber);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        calculateTriangularNumber(10);
        calculateTriangularNumber(20);
        calculateTriangularNumber(50);
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
