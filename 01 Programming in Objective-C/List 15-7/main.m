//
//  main.m
//  List 15-7
//
//  Created by 张思琦 on 15/6/21.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    int i;
    @autoreleasepool {
        //创建一个数组包含月份的名称
        
        NSArray *monthNames = [NSArray arrayWithObjects:
        @"January",@"February",@"March",@"April",
        @"May",@"June",@"July",@"August",@"September",
        @"October",@"November",@"December",nil];
        
        //列出数组中的所有元素
        
        NSLog(@"MOonth        Name");
        NSLog(@"==================");
        
        for (i = 0; i < 12; ++i) {
            NSLog(@"%2i         %@", i+1, [monthNames objectAtIndex:i]);
        }
        
        
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
