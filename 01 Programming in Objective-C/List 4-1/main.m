//
//  main.m
//  List 4-1
//
//  Created by 张思琦 on 15/6/9.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int     integerVar = 100;
        float   floatingVar = 331.79;
        double  doubleVar = 8.44e+11;
        char    charVar = 'W';
        
        NSLog(@"integerVar = %i", integerVar);
        NSLog(@"floatingVar = %f", floatingVar);
        NSLog(@"doubleVar = %e", doubleVar);
        NSLog(@"doubleVar = %g", doubleVar);
        NSLog(@"charVar = %c",charVar);
        
        
        
        NSLog(@"Hello, World!");
    }
    return 0;
}
