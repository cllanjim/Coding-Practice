//
//  main.m
//  List 6-6
//
//  Created by 张思琦 on 15/6/10.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        int number, sign;
        NSLog(@"Please type in a number :");
        scanf("%i",&number);
        
        if (number < 0) {
            sign = -1;
        } else if(0 == number)
        {
            sign = 0;
        }else
        {
            sign = 1;
        }
        
        NSLog(@"Sign = %i",sign);
        NSLog(@"Hello, World!");
    }
    return 0;
}
