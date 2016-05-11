//
//  main.m
//  List 13-8
//
//  Created by 张思琦 on 15/6/15.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        int foo = 10;
        
        void(^printFoo)(void) =
        ^(void){
            NSLog(@"Foo = %i", foo);
        };
        
        foo = 15;

        printFoo();
        
        NSLog(@"Hello, World!");
    }
    return 0;
}
