//
//  ViewController.m
//  0909 RunLoop Observer
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
    //1 创建监听对象
    //CFAllocatorRef allocator                      告诉系统如何给Observer对象分配存储空间
    //CFOptionFlags activities                      需要监听的类型
    //Boolean repeats                               是否需要重复监听
    //CFIndex order                                 优先级
    //CFRunLoopActivity activity) {    code    })   监听到对应的状态之后的回调
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        //observer  RunLoop的Observer对象
        //activity  RunLoop的Mode类型
        switch (activity) {
            case kCFRunLoopEntry:
                NSLog(@"进入RunLoop");
                break;
            case kCFRunLoopBeforeTimers:
                NSLog(@"即将处理timer");
                break;
            case kCFRunLoopBeforeSources:
                NSLog(@"即将处理source");
                break;
            case kCFRunLoopBeforeWaiting:
                NSLog(@"即将进入睡眠");
                break;
            case kCFRunLoopAfterWaiting:
                NSLog(@"刚刚从睡眠中醒来");
                break;
            case kCFRunLoopExit:
                NSLog(@"退出RunLoop");
                break;
                
            default:
                break;
        }
    });
    
    
    //2 给主线程的RunLoop添加对象
    /*
     第一个参数:需要监听的RunLoop对象
     第二个参数:给指定的RunLoop对象添加的监听对象
     第三个参数:在那种模式下监听
     */
    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopCommonModes);
    
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(demo) userInfo:nil repeats:YES];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)demo
{
    NSLog(@"%s", __func__);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
