//
//  main.m
//  List 13-1
//
//  Created by 张思琦 on 15/6/15.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        int Fibonacci[15], i;
        
        Fibonacci[0] = 0;
        Fibonacci[1] = 1;
        
        for (i = 2; i< 15; ++i)
        {
            Fibonacci[i] = Fibonacci[i-2] + Fibonacci[i-1];
        }
        
        for (i = 0; i < 15; ++i) {
            NSLog(@"%i",Fibonacci[i]);
        }
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
