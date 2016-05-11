//
//  main.m
//  List 18-1
//
//  Created by 张思琦 on 15/7/3.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSMutableArray *dataArray = [NSMutableArray arrayWithObjects:
        @"one",
        @"two",
        @"three",
        @"four",
        nil];
        
        NSMutableArray *dataArray2;
        
        //简单赋值
        dataArray2 = dataArray;
        [dataArray2 removeObjectAtIndex:0];
        
        NSLog(@"dataArray: ");
        for (NSString *elem in dataArray) {
            NSLog(@"%@", elem);
        }
        
        NSLog(@"dataArray2: ");
        for (NSString *elem in dataArray2) {
            NSLog(@"%@",elem);
        }
        
        //复制一份,然后删除副本的第一个元素
        dataArray2 = [dataArray mutableCopy];
        [dataArray2 removeObjectAtIndex:0];
        
        NSLog(@"dataArray: ");
        for (NSString *elem in dataArray) {
            NSLog(@"%@", elem);
        }
        
        NSLog(@"dataArray2: ");
        for (NSString *elem in dataArray2) {
            NSLog(@"%@",elem);
        }
        
        
        
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
