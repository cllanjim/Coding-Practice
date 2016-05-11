//
//  main.m
//  List 15-8
//
//  Created by 张思琦 on 15/6/22.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray *monthNames = @[@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December"];
        
        //列出数组中的所有元素
        NSLog(@"Month     Name");
        NSLog(@"==============");
        
        for (int i = 0; i < 12; ++i) {
            NSLog(@"%2i     %@", i+1, monthNames[i]);
        }
        
        
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
