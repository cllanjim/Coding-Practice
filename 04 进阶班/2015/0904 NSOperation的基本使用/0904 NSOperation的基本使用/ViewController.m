//
//  ViewController.m
//  0904 NSOperation的基本使用
//
//  Created by 张思琦 on 15/9/4.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "SQOperation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //NSOperation是基类 包含
    //1. NSBlockOperation
    //2. NSInvocationOperation
    
    
    /**************************** NSInvocationOperation类 ******************/
//    //GCD中的执行流程
//    //1 创建队列
//    //2 创建任务
//    //3 在队列里添加任务
//    
//    //相当于创建了任务
//    //NSInvocationOperation对象中一次只能封装一个任务,最多也只能封装一个任务
//    //任务就是执行self的demo方法
//    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(demo) object:nil];
//    //默认在主线程中执行任务
//    [operation start];
    
    /**************************** NSBlockOperation类 ******************/

//    //相当于创建了任务
//    //NSInvocationOperation对象中一次只能封装一个任务,最多可以封装N个任务
//    //任务就是block中的代码
//    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"Hello World1");
//        NSLog(@"%@",[NSThread currentThread]);
//    }];
//    
//    [operation addExecutionBlock:^{
//        NSLog(@"Hello World2");
//        NSLog(@"%@",[NSThread currentThread]);
//    }];
//    
//    //第一个任务会在主线程中执行
//    //第二个任务会在子线程中执行
//    [operation start];
    
    
    /**************************** 自定义NSOperation类 ******************/
    SQOperation *operation = [[SQOperation alloc] init];
    
    [operation start];
    
}


- (void)demo{
    NSLog(@"Hello World");
    NSLog(@"%@",[NSThread currentThread]);
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
