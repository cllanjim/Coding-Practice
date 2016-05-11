//
//  main.m
//  List 6-5
//
//  Created by 张思琦 on 15/6/10.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        
        int year, rem_4, rem_100, rem_400;
        
        NSLog(@"Enter the year to be tested:");
        scanf("%i", &year);
        
        
        rem_4 = year % 4;
        rem_100 = year % 100;
        rem_400 = year % 400;
        
        if ((0 == rem_4 && 0 != rem_100) || 0 == rem_400) {
            NSLog(@"It's a leap year.");
        } else {
            NSLog(@"It's not a leap year.");
        }
        
        
        NSLog(@"Hello, World!");
    }
    return 0;
}
