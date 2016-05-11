//
//  ViewController.m
//  0909 RunLoop -NSTimer与GCDTimer的区别
//
//  Created by 张思琦 on 15/9/9.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1创建timer
    //1.1 创建队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    //1.2 创建timer
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //2设置timer的参数
    //第一个参数: 需要设置哪个timer
    //第二个参数: 指定定时器开始的时间
    //如果想让timer延迟几秒后执行,可以使用如下的方法
    //1.创建新的启动时间
    dispatch_time_t startTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
    //2.替换DISPATCH_TIME_NOW参数
    dispatch_source_set_timer(timer, startTime, 2.0 * NSEC_PER_SEC, 0.1 * NSEC_PER_SEC);

    /*
    ************** 注意 **************
     下拉方法中,dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC))参数就代表从timer生效后延迟几秒后开始执行
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        code to be executed after a specified delay
    });
    */
    
    //第三个参数: 指定间隔时间
    //第四个参数: 定时器的精准度, 如果传0代表要求非常精准(系统会让定时器执行的时间变得更加准确) 如果传入一个大于0的值, 就代表我们允许的误差
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC, 0.1 * NSEC_PER_SEC);
    
    //3设置timer的回调
    dispatch_source_set_event_handler(timer, ^{
        NSLog(@"%@",[NSThread currentThread]);
    });
    //4开始执行timer
    dispatch_resume(timer);
    
    //5赋值
    //timer对象在viewDidLoad执行完毕后会销毁,所以用自身属性保存起来,保证其能一直存在
    //NSTimer对象是添加到RunLoop中所以不会被销毁
    self.timer = timer;
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
