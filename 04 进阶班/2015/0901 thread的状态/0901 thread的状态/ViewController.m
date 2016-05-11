//
//  ViewController.m
//  0901 thread的状态
//
//  Created by 张思琦 on 15/9/1.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1 创建子线程
    // 此时thread的状态为new
    //这句话也可以理解为在子线程thread中执行self的task:任务,同时给task:方法传入的参数为"ZSQ"
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(task:) object:@"ZSQ"];
    
    //2 启动子线程
    // 此时thread的状态为runnable
    [thread start];

}

- (void)task:(NSString *)name
{
    //3 当进入到此处时,代表task方法在执行,同时也证明了thread正在被cpu调用,此时thread状态为running
    for (int i = 1; i <= 50; i++) {
        NSLog(@"%@  ----  %i", [NSThread currentThread], i);
        
        if (i % 5 == 0){
            //4 此时thread状态为blocked
            //哪个线程调用了sleep相关的方法就让哪个线程进入sleep状态
            //线程进入sleep状态,在设定的 时间间隔 后恢复runnable状态
            [NSThread sleepForTimeInterval:2];
            //线程进入sleep状态,在设定的 时间点  后恢复runnable状态
//            [NSThread sleepUntilDate:[NSDate distantFuture]];
        }
        
        //5 此时线程进入dead状态
        // 哪个线程调用exit方法,哪个线程就被强制销毁
        if (i == 11){
            //[NSThread exit];
            // [NSThread exit] == return
//            return;
            // 线程被销毁后,后面的代码将无法执行
            NSLog(@"I will never be printed");
        }
    }
    
}//当代码执行到此处,线程会自然消亡




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
