//
//  main.m
//  List 13-10
//
//  Created by 张思琦 on 15/6/15.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        struct data
        {
            int month;
            int day;
            int year;
        };
        
        struct data today;
        today.month = 9;
        today.day = 25;
        today.year = 2014;
        
        NSLog(@"Today's date is %i/%i/%.02i", today.month, today.day, today.year % 100);
        
        // insert code here...
        NSLog(@"Hello, World!");
    }
    

    return 0;
}
