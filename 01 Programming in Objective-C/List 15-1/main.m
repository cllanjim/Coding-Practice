//
//  main.m
//  List 15-1
//
//  Created by 张思琦 on 15/6/18.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSNumber        *myNumber, *floatNumber, *intNumber;
        NSInteger       myInt;
        
        //Integer型值
        
        intNumber = [NSNumber numberWithInteger:100];
        myInt = [intNumber integerValue];
        NSLog(@"%li", (long) myInt);
        
        //long型值
        
        myNumber = [NSNumber numberWithLong:0Xabcdef];
        NSLog(@"%lx",[myNumber longValue]);
        
        //char型值
        
        myNumber = [NSNumber numberWithChar:'x'];
        NSLog(@"%c",[myNumber charValue]);
        
        //float型值
        
        floatNumber = [NSNumber numberWithFloat:100.00];
        NSLog(@"%g", [floatNumber floatValue]);
        
        //double型值
        
        myNumber = [NSNumber numberWithDouble:12345e+15];
        NSLog(@"%lg",[myNumber floatValue]);
        
        //发生错误
        
        NSLog(@"%li",(long) [myNumber integerValue]);
        
        //验证两个Number是否相等
        
        if ([intNumber isEqualToNumber:floatNumber] == YES)
            NSLog(@"Numbers are equal");
        else
            NSLog(@"Numbers are not equal");
        
        //验证一个Number是否小于,等于或大于另一个Number
        if ([intNumber compare:myNumber] == NSOrderedAscending)
            NSLog(@"First number is less than second");
        
              
        
        
        
        NSLog(@"Hello, World!");
    }
    return 0;
}
