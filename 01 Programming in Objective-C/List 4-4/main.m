//
//  main.m
//  List 4-4
//
//  Created by 张思琦 on 15/6/10.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int a = 25, b = 5, c = 10, d = 7;
        
        NSLog(@"a %% b = %i", a % b);
        NSLog(@"a %% c = %i", a % c);
        NSLog(@"a %% d = %i", a % d);
        NSLog(@"a / d * d + a %% d = %i", a / d * d + a % d);

        
        
        NSLog(@"Hello, World!");
    }
    return 0;
}
