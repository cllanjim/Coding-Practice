//
//  main.m
//  List 5.4
//
//  Created by 张思琦 on 15/6/10.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int n, number , triangularNumber;
        
        NSLog(@"What triangularNumber do you want?");
        scanf("%i", &number);
        
        triangularNumber = 0;
        
        for ( n = 1; n < number ; ++n)
        {
            triangularNumber += n;
        }
        
        NSLog(@"Triangular number %i is %i \n", number, triangularNumber);
        NSLog(@"Hello, World!");
    }
    return 0;
}
