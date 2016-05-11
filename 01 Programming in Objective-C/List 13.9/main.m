//
//  main.m
//  List 13.9
//
//  Created by 张思琦 on 15/6/15.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int foo = 10;
        
        void (^printFoo)()=
        ^(void){
            //foo = 20;
            NSLog(@"Foo = %i", foo);
        };
        
       // NSLog(@"printFoo()= %p", printFoo);
        foo = 15;
        //NSLog(@"Foo is %i", foo);
        printFoo();
        NSLog(@"Hello, World!");
    }
    return 0;
}
