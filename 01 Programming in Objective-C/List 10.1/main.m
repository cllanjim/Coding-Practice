//
//  main.m
//  List 10.1
//
//  Created by 张思琦 on 15/6/13.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fraction.h"
#import "Foo.h"

int gGlobalVar = 5;

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Fraction *a, *b;
        
        a = [[Fraction alloc] initWith:1 over:3];
        b = [[Fraction alloc] initWith:3 over:7];
        
        [a print];
        [b print];
        
        //[a release];
        //[b release];
        
        Foo *myFoo = [[Foo alloc] init];
        NSLog(@" %i ", gGlobalVar);
        
        [myFoo setgGlobalVal:100];
        NSLog(@" %i ", gGlobalVar);
        
        NSLog(@"Hello, World!");
    }
    return 0;
}
