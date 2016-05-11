//
//  main.m
//  List 10-3
//
//  Created by 张思琦 on 15/6/13.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        enum month {    january = 1,
                        february,
                        march,
                        april,
                        may ,
                        june,
                        july,
                        august,
                        september,
                        october,
                        november,
                        december};
        
        enum month amonth;
        int days;
        
        NSLog(@"Enter month number:");
        scanf("%i",&amonth);
        
        switch (amonth) {
            case january:
            case march:
            case may:
            case july:
            case august:
            case december:
                days = 31;
                break;
            case april:
            case june:
            case september:
            case november:
                days = 30;
                break;
            case february:
                days = 28;
                break;
            default:
                NSLog(@"Bad month number");
                break;
        }
        
        if (0 != days) {
            NSLog(@"Number of days is %i",days);
        }
        
        if (amonth == february) {
            NSLog(@"... or 29 if it is a leap year.");
        }
        
        NSLog(@"Hello, World!");
    }
    return 0;
}
