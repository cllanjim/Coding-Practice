//
//  main.m
//  List 18-2
//
//  Created by 张思琦 on 15/7/3.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSMutableArray *dataArray = [NSMutableArray arrayWithObjects:
                                     [NSMutableString stringWithString:@"one"],
                                     [NSMutableString stringWithString:@"two"],
                                     [NSMutableString stringWithString:@"three"],
                                     [NSMutableString stringWithString:@"four"],
                                     nil
                                     ];
        NSMutableArray *dataArray2;
        NSMutableString *mStr;
        
        NSLog(@"dataArray: ");
        for (NSString *elem in dataArray) {
            NSLog(@"%@",elem);
        }
        
        
        //复制一份,然后删除副本的第一个元素
        dataArray2 = [dataArray mutableCopy];
        //mStr = dataArray[0];
        //[mStr appendString:@"ONE"];
        
        //测试
        mStr = [NSMutableString stringWithString:dataArray2[0]];
        [mStr appendString:@"ONE"];
        [dataArray2 replaceObjectAtIndex:0 withObject:mStr];
        
        
        
        NSLog(@"dataArray: ");
        for (NSString *elem in dataArray) {
            NSLog(@"%@",elem);
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
