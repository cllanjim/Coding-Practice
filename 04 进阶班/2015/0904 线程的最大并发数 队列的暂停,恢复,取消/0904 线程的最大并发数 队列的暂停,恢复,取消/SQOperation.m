//
//  SQOperation.m
//  0904 线程的最大并发数 队列的暂停,恢复,取消
//
//  Created by 张思琦 on 15/9/4.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "SQOperation.h"

@implementation SQOperation

- (void)main{
    for (int i = 0; i < 2000; i++) {
        NSLog(@"i = %i, 111111", i);
    }
    NSLog(@"%@",[NSThread currentThread]);
    NSLog(@"第1个任务执行完毕");
    
    if (self.cancelled) {
        return;
    }
    
    for (int i = 0; i < 2000; i++) {
        NSLog(@"i = %i, 111111", i);
    }
    NSLog(@"%@",[NSThread currentThread]);
    NSLog(@"第2个任务执行完毕");
    
    if (self.cancelled) {
        return;
    }
    
    for (int i = 0; i < 2000; i++) {
        NSLog(@"i = %i, 111111", i);
    }
    NSLog(@"第3个任务执行完毕");
    if (self.cancelled) {
        return;
    }
}

@end
