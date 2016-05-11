//
//  ViewController.m
//  0422 Block的回调
//
//  Created by 张思琦 on 16/4/22.
//  Copyright © 2016年 SketchK. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadData0];
    
    [self loadData1:^{
        NSLog(@"这是回调block");
    }];
    
    [self loadData3:@"回调函数" block:^(NSString *blockName) {
        NSLog(@"%@", blockName);
        NSLog(@"打印出来的东西是回调函数");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//耗时操作
- (void)loadData0{
    //创建子线程进行耗时操作
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"进入子线程进行耗时操作,且耗时操作完毕 - %@",[NSThread currentThread]);
        
        //耗时操作完毕后,回到主线程进行UI刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"回到主线程进行UI刷新操作,且刷新操作完毕 - %@",[NSThread currentThread]);
        });
    });
}

//带有回调block的耗时操作
- (void)loadData1:(void (^)())block{
    //创建子线程进行耗时操作
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"进入子线程进行耗时操作,且耗时操作完毕 - %@",[NSThread currentThread]);
        
        //耗时操作完毕后,回到主线程进行UI刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"回到主线程进行UI刷新操作,且刷新操作完毕 - %@",[NSThread currentThread]);
            block();
        });
    });
}

//带有参数和回调block的耗时操作
- (void)loadData3:(NSString *)name block:(void (^)(NSString *blockName))block{
    //创建子线程进行耗时操作
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"进入子线程进行耗时操作,且耗时操作完毕 - %@",[NSThread currentThread]);
        
        //耗时操作完毕后,回到主线程进行UI刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"回到主线程进行UI刷新操作,且刷新操作完毕 - %@",[NSThread currentThread]);
            block(name);
        });
    });
}

@end
