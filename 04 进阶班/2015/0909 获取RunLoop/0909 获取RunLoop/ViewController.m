//
//  ViewController.m
//  0909 获取RunLoop
//
//  Created by 张思琦 on 15/9/9.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //利用CoreFoundation框架获得RunLoop对象的方法
    //获得主线程中的RunLoop对象,返回值为CFRunLoopRef
    CFRunLoopGetMain();
    //获得子线程中的RunLoop对象,返回值为CFRunLoopRef
    CFRunLoopGetCurrent();
    
    
    //利用Foundation框架获得RunLoop对象
    //获取主线程的RunLoop
    NSRunLoop *mainrl = [NSRunLoop mainRunLoop];
    NSLog(@"%@",mainrl);
    
    
    //获取子线程中的RunLoop
    //1 创建队列
    dispatch_queue_t queue1 = dispatch_queue_create("ZSQ", NULL);
    dispatch_queue_t queue2 = dispatch_get_global_queue(0, 0);
    //2 以异步方式将任务和队列启动
    dispatch_async(queue2, ^{
        // 如果是在子线程中调用currentRunLoop, 那么系统首先会查看, 当前子线程是否有对应的NSRunLoop, 如果没有就创建一个
        // 注意: 如果想给子线程添加一个与之对应的NSRunLoop, 不能通过alloc/init \ 需要通过currentRunLoop
        NSRunLoop *rl2 = [NSRunLoop currentRunLoop];
        NSLog(@"%@",rl2);
        
    });
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
