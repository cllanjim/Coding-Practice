//
//  main.m
//  List 15-9
//
//  Created by 张思琦 on 15/6/22.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSMutableArray *numbers = [NSMutableArray array];
        int i;
        
        //创建0-9的数组
        for(i = 0; i < 10; ++i)
        {
            numbers[i] = @(i);
        }
        
        //遍历数组与显示值
        for (i = 0; i < 10; ++i) {
            NSLog(@"%@",numbers[i]);
        }
        
        
        //使用带有%@格式的NSLog显示
        NSLog(@"=====Using a single NSLog");
        NSLog(@"%@",numbers);
        
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
