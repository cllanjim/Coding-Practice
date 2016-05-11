//
//  ViewController.m
//  0904 NSOperationQueue的基本使用
//
//  Created by 张思琦 on 15/9/4.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //GCD的使用思路
    //1 创建队列
    //2 创建任务
    //3 添加任务到队列中
    
    //NSOperation的使用思路
    //1. 创建队列
    //2. 创建NSOperation并添加任务
    //3. 将NSOperation添加到队列中
    
    
    /*************************** 添加NSInvocationOperation *********************/
//    //创建队列
//    //自定义队列 alloc/init   默认是并发(通过调整属性可以变成串行)
//    NSOperationQueue *queue1 = [[NSOperationQueue alloc] init];
//    
//    //主队列
//    NSOperationQueue *queue2 = [NSOperationQueue mainQueue];
//    
//    //创建NSOperation并添加任务
//    NSInvocationOperation *operation1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(demo) object:nil];
//    
//    //将NSOperation添加到队列中
////    [queue1 addOperation:operation1];
//    [queue2 addOperation:operation1];
    
    
    /*************************** 添加NSInvocationOperation *********************/
    //创建队列
    //自定义队列 alloc/init   默认是并发(通过调整属性可以变成串行)
    NSOperationQueue *queue1 = [[NSOperationQueue alloc] init];
    //主队列
    NSOperationQueue *queue2 = [NSOperationQueue mainQueue];
    
    //创建NSBlockOperation并添加任务
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"demo = %@", [NSThread currentThread]);
    }];
    
    //将NSBlockOperation添加到队列中
    [queue1 addOperation:operation];
    
    //可以使用addOperationWithBlock简化操作
    // 1.根据传入的block, 创建一个NSBlockOperation对象
    // 2.将内部创建好的NSBlockOperation对象, 添加到队列中
    [queue1 addOperationWithBlock:^{
        NSLog(@"demo = %@", [NSThread currentThread]);
    }];
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)demo
{
    NSLog(@"demo = %@", [NSThread currentThread]);
}
@end
