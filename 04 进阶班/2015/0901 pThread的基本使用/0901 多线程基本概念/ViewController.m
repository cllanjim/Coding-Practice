//
//  ViewController.m
//  0901 多线程基本概念
//
//  Created by 张思琦 on 15/9/1.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import <pthread/pthread.h>

@interface ViewController ()

@end

@implementation ViewController

void *task(void *parameter){
    //打印主线程
    NSLog(@"%@", [NSThread currentThread]);
    //打印参数
    NSLog(@"%s", parameter);
    return NULL;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //1 创建子线程
    pthread_t subThread;
    //2 将任务添加到子线程中
//    第一个参数pthread_t *restrict                    线程代号(线程对象)
//    第二个参数const pthread_attr_t *restrict         线程的属性
//    第三个参数void *(*)(void *)                      子线程需要执行的操作,即调用的方法(回调函数)
//                                                   该参数为指向函数的指针 返回值(*指针名称)参数列表
//                                                   (void *)相当于oc中的id
//    第四个参数void *restrict                         给第三个参数传递的值
    pthread_create(&subThread, NULL, task, "ZSQ");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
