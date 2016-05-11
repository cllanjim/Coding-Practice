//
//  main.m
//  List 13-12
//
//  Created by 张思琦 on 15/6/15.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        char c = 'Q';
        char *charPtr = &c;
        
        NSLog(@"%c %c", c, *charPtr);
        
        c = '/';
        NSLog(@"%c %c", c, *charPtr);
        
        *charPtr = '(';
        NSLog(@"%c %c", c, *charPtr);
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
