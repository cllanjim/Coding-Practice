//
//  ViewController.m
//  0901 GCD的基本使用
//
//  Created by 张思琦 on 15/9/2.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /*************************创建队列******************************/
    //创建队列,确定任务的执行方式

    //方法一 手动创建队列
    /*
    第一个参数: 队列的名称
    第二个参数: 告诉系统需要创建一个并发队列还是串行队列
    DISPATCH_QUEUE_SERIAL :串行
    DISPATCH_QUEUE_CONCURRENT　并发
    */
    dispatch_queue_t queue0 = dispatch_queue_create("ZSQ", DISPATCH_QUEUE_CONCURRENT);
    
    //方法二
    //2.1 使用系统内部提供的并发队列
    //2.2 自定义一个全局的并发队列
    //
    /*
     第一个参数: iOS8以前是优先级, iOS8以后是服务质量
     iOS8以前
     *  - DISPATCH_QUEUE_PRIORITY_HIGH          高优先级 2
     *  - DISPATCH_QUEUE_PRIORITY_DEFAULT:      默认的优先级 0
     *  - DISPATCH_QUEUE_PRIORITY_LOW:          低优先级 -2
     *  - DISPATCH_QUEUE_PRIORITY_BACKGROUND:
     
     iOS8以后
     *  - QOS_CLASS_USER_INTERACTIVE  0x21 用户交互(用户迫切想执行任务)
     *  - QOS_CLASS_USER_INITIATED    0x19 用户需要
     *  - QOS_CLASS_DEFAULT           0x15 默认
     *  - QOS_CLASS_UTILITY           0x11 工具(低优先级, 苹果推荐将耗时操作放到这种类型的队列中)
     *  - QOS_CLASS_BACKGROUND        0x09 后台
     *  - QOS_CLASS_UNSPECIFIED       0x00 没有设置
     
     第二个参数: 废物
     
     注意点:在实际开发过程中,将第一个参数设置为0会方便各个系统版本的识别
     
     */
    dispatch_queue_t queue1 = dispatch_get_global_queue(0, 0);
    
    /*************************执行任务******************************/
    //创建任务的执行方式,并将任务添加到创建好的队列中

    /*
     执行任务
     dispatch_async  异步方式执行任务
     dispatch_sync   同步方式执行任务
     
     第一个参数: 用于存放任务的队列
     第二个参数: 任务(block)
     
     GCD从队列中取出任务, 遵循FIFO原则 , 先进先出
     输出的结果和苹果所说的原则不符合的原因: CPU可能会先调度其它的线程
     
     能够创建新线程的原因:      我们是使用"异步"函数调用
     能够创建多个子线程的原因:   我们的队列是并发队列
     */
    dispatch_async(queue0, ^{
        NSLog(@"任务1  == %@", [NSThread currentThread]);
    });
    dispatch_async(queue0, ^{
        NSLog(@"任务1  == %@", [NSThread currentThread]);
    });
    dispatch_async(queue0, ^{
        NSLog(@"任务1  == %@", [NSThread currentThread]);
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
