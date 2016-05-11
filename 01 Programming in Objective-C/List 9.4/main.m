//
//  main.m
//  List 9.4
//
//  Created by 张思琦 on 15/6/12.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fraction.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Fraction *f = [[[Fraction class] alloc] init];
        [f noSochMethod];
        NSLog(@"Execution continues!");
        
        
        
        NSLog(@"Hello, World!");
    }
    return 0;
}
