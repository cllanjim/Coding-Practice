//
//  main.m
//  List 13-11
//
//  Created by 张思琦 on 15/6/15.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int count = 10, x;
        
        int *intPtr;
        
        intPtr = &count ;
        x = *intPtr;
        
        NSLog(@"Count = %i, x = %i", count, x);
        
        
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
