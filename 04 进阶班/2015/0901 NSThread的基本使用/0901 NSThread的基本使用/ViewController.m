//
//  ViewController.m
//  0901 NSThread的基本使用
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
    
    //1 创建线程 Thread
    //target:       子线程要调用谁的方法
    //selectior:    被子线程调用的方法
    //object:       给被调用方法传入参数
    NSThread *thread00 = [[NSThread alloc] initWithTarget:self selector:@selector(task:) object:@"ZSQ"];
    thread00.name = @"子线程00";
    thread00.threadPriority = 0.4;
    //2 线程开始工作
    [thread00 start];
    
    NSThread *thread01 = [[NSThread alloc] initWithTarget:self selector:@selector(task:) object:@"SK"];
    thread01.name = @"子线程01";
    thread01.threadPriority = 0.8;
    [thread01 start];
    
    
    [NSThread detachNewThreadSelector:@selector(task:) toTarget:self withObject:@"XXX"];

    [self performSelectorInBackground:@selector(task:) withObject:@"ZZZ"];
    
    
//    NSLog(@"This Method is ending");
}
/************************************************/
- (void)task:(NSString *)name
{
//    NSLog(@"%@", [NSThread currentThread]);
//    NSLog(@"%@", name);
    for (int i = 0; i < 100; i++) {
        NSLog(@"%@ ------ %i", [NSThread currentThread].name ,i);
    }

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
