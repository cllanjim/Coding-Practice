//
//  ViewController.m
//  0902 GCD中任务执行方式和任务队列的组合
//
//  Created by 张思琦 on 15/9/2.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

typedef void (^TaskBlock) (void);

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
    //异步 + 并发
//    [self asyncCONCURRENT];

    //异步 + 串行
//    [self asyncSERIAL];
    
    //同步 + 并发
//    [self syncCONCURRENT];
    
    //同步 + 串行
//    [self syncSERIAL];
    
    //异步 + 主队列
//    [self asyncMain];
    
    
    

}




/****************************   主队列   ******************************/
//主队列的概念
//主队列是GCD自带的一种特殊的串行队列
//只要将任务添加到主队列中,不论使用同步函数还是异步函数执行任务,都将会在主线程中执行


//以异步方式执行任务 + 主队列
- (void)asyncMain{
    //1 创建主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    //2 创建任务
    //2 创建任务
    TaskBlock task00 = ^ void (){
        NSLog(@"Begin This Task");
        NSLog(@"task00----%@",[NSThread currentThread]);
        NSLog(@"Finish This Task");
    };
    TaskBlock task01 = ^ void (){
        NSLog(@"Begin This Task");
        NSLog(@"task01----%@",[NSThread currentThread]);
        NSLog(@"Finish This Task");
    };
    TaskBlock task02 = ^ void (){
        NSLog(@"Begin This Task");
        NSLog(@"task02----%@",[NSThread currentThread]);
        NSLog(@"Finish This Task");
    };
    //3 以异步方式执行任务
    dispatch_async(queue, task00);
    dispatch_async(queue, task01);
    dispatch_async(queue, task02);
    
    NSLog(@"Tasks have done");
    
    //1 主队列            表示   任务只能按照顺序一个一个完成
    //2 异步方式执行任务    表示   具备开启新线程的能力
    //3 异步 + 主队列      表示   由于任务在主队列中,则在主线程中执行任务
    //4 不会造成死锁   主线程中有主队列(串行任务)
    
    
}

//以同步方式执行任务 + 主队列
- (void)syncMain
{
    //1 创建主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    //2 创建任务
    TaskBlock task00 = ^ void (){
        NSLog(@"Begin This Task");
        NSLog(@"task00----%@",[NSThread currentThread]);
        NSLog(@"Finish This Task");
    };
    TaskBlock task01 = ^ void (){
        NSLog(@"Begin This Task");
        NSLog(@"task01----%@",[NSThread currentThread]);
        NSLog(@"Finish This Task");
    };
    TaskBlock task02 = ^ void (){
        NSLog(@"Begin This Task");
        NSLog(@"task02----%@",[NSThread currentThread]);
        NSLog(@"Finish This Task");
    };
    //3 以异步方式执行任务
    dispatch_sync(queue, task00);
    dispatch_sync(queue, task01);
    dispatch_sync(queue, task02);
    
    NSLog(@"Tasks have done");
    
    //1 主队列            表示   任务只能按照顺序一个一个完成
    //2 同步方式执行任务    表示   不会开启新线程
    //3 同步 + 主队列      表示    由于任务在主队列中,则在主线程中执行任务
    //4 会造成死锁   主线程中有主队列(串行任务)
    
    
}

/****************************   主队列   ******************************/




/****************************   同步方式执行任务   ******************************/

//同步方式执行任务 + 并发任务队列
- (void)syncCONCURRENT{
    //1 创建并发任务队列
    dispatch_queue_t queue = dispatch_queue_create("ZSQ", DISPATCH_QUEUE_CONCURRENT);
    //2 创建任务
    TaskBlock task00 = ^ void (){
        NSLog(@"Begin This Task");
        NSLog(@"task00----%@",[NSThread currentThread]);
        NSLog(@"Finish This Task");
    };
    TaskBlock task01 = ^ void (){
        NSLog(@"Begin This Task");
        NSLog(@"task01----%@",[NSThread currentThread]);
        NSLog(@"Finish This Task");
    };
    TaskBlock task02 = ^ void (){
        NSLog(@"Begin This Task");
        NSLog(@"task02----%@",[NSThread currentThread]);
        NSLog(@"Finish This Task");
    };
    //3 以异步方式执行任务
    dispatch_sync(queue, task00);
    dispatch_sync(queue, task01);
    dispatch_sync(queue, task02);
    
    NSLog(@"Tasks have done");
    
    //1 并发队列         表示      允许多个任务同时执行
    //2 同步方式执行任务  表示      在当前线程中执行任务,不具备开启新线程的能力
    //3 同步 + 并发      表示      在当前线程中执行任务
    //4 当前线程执行dispatch_sync(queue, task00); task00, task01, task02
    //  所以处理当前情况是一个时间轴
    //5 执行流程概述:
    /*
     
     当前线程的时间轴
     5.1.1 系统按照顺序执行    dispatch_async(queue, task00);
     5.1.2 dispatch_sync(queue, task00)意思是告诉系统有一个并发的任务队列,并且以同步的方式执行
     5.1.3 基于此系统将task00添加到当前线程中
     5.1.4 执行task00?
     5.1.5
     5.1.6 重复上述操作
     5.1.7 最后执行           NSLog(@"Tasks have done");
     
     
     
     总结:
     
     
     */
}

//同步方式执行任务 + 串行任务队列
- (void)syncSERIAL{
    //1 创建串行任务队列
    dispatch_queue_t queue = dispatch_queue_create("ZSQ", DISPATCH_QUEUE_SERIAL);
    //2 创建任务
    TaskBlock task00 = ^ void (){
        NSLog(@"Begin This Task");
        NSLog(@"task00----%@",[NSThread currentThread]);
        NSLog(@"Finish This Task");
    };
    TaskBlock task01 = ^ void (){
        NSLog(@"Begin This Task");
        NSLog(@"task01----%@",[NSThread currentThread]);
        NSLog(@"Finish This Task");
    };
    TaskBlock task02 = ^ void (){
        NSLog(@"Begin This Task");
        NSLog(@"task02----%@",[NSThread currentThread]);
        NSLog(@"Finish This Task");
    };
    //3 以异步方式执行任务
    dispatch_sync(queue, task00);
    dispatch_sync(queue, task01);
    dispatch_sync(queue, task02);
    
    NSLog(@"Tasks have done");
    //总结
    //1 串行队列           表示   任务只能按顺序执行
    //2 同步方式执行任务    表示   在当前线程中执行任务,不具备开启多线程的能力
    //3 同步 + 串行        表示   在当前线程中执行任务,任务按照顺序执行
    //4 当前线程执行dispatch_sync(queue, task00); task00, task01, task02
    //  所以处理当前情况是一个时间轴,
    //5 执行流程概述:
    /*
     
     当前线程的时间轴
     5.1.1 系统按照顺序执行    dispatch_async(queue, task00);
     5.1.2 dispatch_sync(queue, task00)意思是告诉系统有一个串行的任务队列,并且以同步的方式执行
     5.1.3 基于此系统将task00添加到当前线程中
     5.1.4 执行task00?
     5.1.5
     5.1.6 重复上述操作
     5.1.7 最后执行           NSLog(@"Tasks have done");
     

     
     总结:
     
     
     */


}

/****************************   异步方式执行任务   ******************************/
// 异步方式执行任务 + 并发任务队列
- (void)asyncCONCURRENT{
    //1 创建并发任务队列
    dispatch_queue_t queue = dispatch_queue_create("ZSQ", DISPATCH_QUEUE_CONCURRENT);
    //2 创建任务
    TaskBlock task00 = ^ void (){
        NSLog(@"Begin This Task");
        NSLog(@"task00----%@",[NSThread currentThread]);
        NSLog(@"Finish This Task");
    };
    TaskBlock task01 = ^ void (){
        NSLog(@"Begin This Task");
        NSLog(@"task01----%@",[NSThread currentThread]);
        NSLog(@"Finish This Task");
    };
    TaskBlock task02 = ^ void (){
        NSLog(@"Begin This Task");
        NSLog(@"task02----%@",[NSThread currentThread]);
        NSLog(@"Finish This Task");
    };
    //3 以异步方式执行任务
    dispatch_async(queue, task00);
    dispatch_async(queue, task01);
    dispatch_async(queue, task02);
    
    NSLog(@"Tasks have done");
    //总结
    //1 并发队列           表示   允许多个任务同时执行
    //2 异步方式执行任务    表示   具备开启多线程的能力
    //3 异步 + 并发        表示   一定会开启新的线程,队列中有多个任务会同时进行
    //4 当前线程执行dispatch_async(queue, task00); 子线程1执行task00,子线程2执行task01,子线程3执行task02
    //  加之当前是并发队列,所以在处理这种情况时是有多个时间轴
    //5 执行流程概述:
    /*
     
     当前线程的时间轴
     5.1.1 系统按照顺序执行    dispatch_async(queue, task00);
     5.1.2 dispatch_async(queue, task00)意思是告诉系统有一个并发的任务队列,并且以异步的方式执行
     5.1.3 基于此系统给task00任务开启新的线程
     5.1.4 重复执行           dispatch_async(queue, task01);
     5.1.5 基于queue是一个并发的任务队列,系统给task01开启另外一个线程
     5.1.6 重复上述操作
     5.1.7 最后执行           NSLog(@"Tasks have done");
     
     子线程的时间轴
     5.2.1 当子线程被创建后
     5.2.2 子线程执行task0X任务(X = 0, 1, 2)

     总结:
     因为开启了新的线程执行queue队列中的任务,所以当前线程中的代码不必等queue队列中的任务被执行完毕
    */
}


// 异步方式执行任务 + 串行任务队列
- (void)asyncSERIAL{
    //1 创建串行任务队列
    dispatch_queue_t queue = dispatch_queue_create("ZSQ", DISPATCH_QUEUE_SERIAL);
    
    //2 创建任务
    TaskBlock task00 = ^ void (){
        NSLog(@"Begin This Task");
        NSLog(@"task00----%@",[NSThread currentThread]);
        NSLog(@"Finish This Task");
    };
    TaskBlock task01 = ^ void (){
        NSLog(@"Begin This Task");
        NSLog(@"task01----%@",[NSThread currentThread]);
        NSLog(@"Finish This Task");
    };
    TaskBlock task02 = ^ void (){
        NSLog(@"Begin This Task");
        NSLog(@"task02----%@",[NSThread currentThread]);
        NSLog(@"Finish This Task");
    };
    //3 以异步方式执行任务
    dispatch_async(queue, task00);
    dispatch_async(queue, task01);
    dispatch_async(queue, task02);
    
    NSLog(@"Tasks have done");
    
    //1 串行队列         表示      多个任务只能按照顺序进行
    //2 异步方式执行任务  表示       具备开启新线程的能力
    //3 异步 + 串行     表示        一定开启新的线程 队列中多个任务会按照顺序进行
    //4 当前线程执行dispatch_async(queue, task00); 子线程执行task00
    //  所以在处理这种情况时是有两个时间轴
    //5 执行流程概述:
    /*
     
     当前线程的时间轴
     5.1.1 系统按照顺序执行    dispatch_async(queue, task00);
     5.1.2 dispatch_async(queue, task00)意思是告诉系统有一个串行的任务队列,并且以异步的方式执行
     5.1.3 基于异步方式,系统给task00任务开启新的线程
     5.1.4 重复执行           dispatch_async(queue, task00);
     5.1.5 基于queue是一个串行的任务队列,第二个task00会放到第一个task00开启的新线程中
     5.1.6 重复上述操作
     5.1.7 最后执行           NSLog(@"Tasks have done");
     
     子线程的时间轴
     5.2.1 当子线程被创建后
     5.2.2 子线程执行task00任务
     5.2.3 后来的task任务会在前面的task任务执行完毕后才被执行
     
     总结:
     因为开启了新的线程执行queue队列中的任务,所以当前线程中的代码不必等queue队列中的任务被执行完毕
     子线程中的任务一定会按照添加顺序依次进行
     */

}


@end
