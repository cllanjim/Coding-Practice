//
//  ViewController.m
//  0904 线程的最大并发数 队列的暂停,恢复,取消
//
//  Created by 张思琦 on 15/9/4.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "SQOperation.h"

@interface ViewController ()

@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1 创建队列
    self.queue = [[NSOperationQueue alloc] init];
////    self.queue = [NSOperationQueue mainQueue];
//    //修改最大并发数,此时为串行队列
//    self.queue.maxConcurrentOperationCount = 1;
//    
//    
//    //2 创建任务
//    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
//        for (int i = 0; i < 2000; i++) {
//            NSLog(@"i = %i, 111111", i);
//        }
//        NSLog(@"%@",[NSThread currentThread]);
//        NSLog(@"第1个任务执行完毕");
//    }];
//    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
//        for (int i = 0; i < 2000; i++) {
//            NSLog(@"i = %i, 111111", i);
//        }
//        NSLog(@"%@",[NSThread currentThread]);
//        NSLog(@"第2个任务执行完毕");
//    }];
//    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
//        for (int i = 0; i < 2000; i++) {
//            NSLog(@"i = %i, 111111", i);
//        }
//        NSLog(@"第3个任务执行完毕");
//    }];
//    
//    [self.queue addOperation:operation1];
//    [self.queue addOperation:operation2];
//    [self.queue addOperation:operation3];
  
    SQOperation *operation = [[SQOperation alloc] init];
    
    [self.queue addOperation:operation];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

//    // 暂停队列中的任务
//    // 如果是YES, 代表需要暂停
//    // 如果是NO ,代表不需要暂停 ==  恢复执行
    self.queue.suspended = YES;
//    NSLog(@"点击屏幕");
//    
//    //方法一
//    if (self.queue.suspended) {
//        // 恢复
//        self.queue.suspended = NO;
//    }else{
//        // 暂停
//        self.queue.suspended = YES;
//    }
//    //方法二
//    self.queue.suspended = !self.queue.suspended;
    
//    [self.queue cancelAllOperations];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
