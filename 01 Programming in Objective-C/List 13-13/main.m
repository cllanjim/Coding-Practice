//
//  main.m
//  List 13-13
//
//  Created by 张思琦 on 15/6/15.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        struct date
        {
            int month;
            int day;
            int year;
        };
        
        struct date today, *datePtr;
        
        datePtr = &today;
        datePtr->month = 9;
        datePtr->day = 25;
        datePtr->year = 2014;
        
        NSLog(@"Today's date is %i/%i/%.2i", datePtr->month, datePtr->day, datePtr->year);
        
        
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
