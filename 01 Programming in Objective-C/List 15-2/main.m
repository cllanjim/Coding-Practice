//
//  main.m
//  List 15-2
//
//  Created by 张思琦 on 15/6/18.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
       
        NSNumber *myNumber, *floatNumber, *intNumber;
        NSInteger myInt;
        
        //整形integer
        intNumber = @100;
        myInt = [intNumber integerValue];
        NSLog(@"%li",(long)myInt);
        
        //长整形long value
        myNumber = @0xabcdefl;
        NSLog(@"%lx", [myNumber longValue]);
        myNumber = @'X';
        NSLog(@"%c",[myNumber charValue]);
        
        //浮点型
        floatNumber = @100.0f;
        NSLog(@"%g",[floatNumber floatValue]);
        
        
        
        
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
