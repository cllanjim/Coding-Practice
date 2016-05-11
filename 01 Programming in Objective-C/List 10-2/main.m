//
//  main.m
//  List 10-2
//
//  Created by 张思琦 on 15/6/13.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fraction.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Fraction *a, *b, *c;
        
        typedef Fraction *FractionObject;
        
        FractionObject myValue1;
        Fraction *myValue1;
        
        
        
        NSLog(@"Fraction allocated: %i",[Fraction count]);
        
        a = [[Fraction allocF] init];
        b = [[Fraction allocF] init];
        c = [[Fraction allocF] init];
        
        NSLog(@"Fraction allocated: %i",[Fraction count]);
        
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
