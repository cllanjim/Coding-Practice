//
//  main.m
//  List 5-2
//
//  Created by 张思琦 on 15/6/10.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int n, triangularNumber;
        
        triangularNumber = 0;
        
        for (n =1; n <=200; n = n + 1 )
        {
            triangularNumber += n;
        }
        
        NSLog(@"The 200th triangular number is %i", triangularNumber);
        NSLog(@"Hello, World!");
    }
    return 0;
}
