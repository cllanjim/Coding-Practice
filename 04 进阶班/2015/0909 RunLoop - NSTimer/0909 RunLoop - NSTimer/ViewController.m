//
//  ViewController.m
//  0909 RunLoop - NSTimer
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
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(print) userInfo:nil repeats:YES];
    
    //将NSTimer添加到主线程的RunLoop的默认模式下,只有主线程NSRunLoop当前是默认模式才会执行Timer
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    //将NSTimer添加到主线程的RunLoop的跟踪模式下,只有主线程NSRunLoop当前是跟踪模式下才会执行Timer
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
    
    //将NSTimer添加到CommonModes中
    //kCFRunLoopCommonModes不是一种真正的model
    //其实Common是一个标识, 它是将NSDefaultRunLoopMode和UITrackingRunLoopMode标记为了Common
    //所以, 只要将timer添加到Common占位模式下,timer就可以在NSDefaultRunLoopMode和UITrackingRunLoopMode模式下都能运行
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)print{
    NSLog(@"This is a test");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
