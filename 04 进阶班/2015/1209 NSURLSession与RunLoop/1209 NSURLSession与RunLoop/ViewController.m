//
//  ViewController.m
//  1209 NSURLSession与RunLoop
//
//  Created by 张思琦 on 15/12/9.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSURLConnectionDataDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   
    NSLog(@"---------------");
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/login?username=520it&pwd=520it&type=JSON"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
//    [NSURLConnection connectionWithRequest:request delegate:self];
    
    //connection本身在主线程中执行
    //connection的代理方法在子线程中执行
//    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
//    [connection setDelegateQueue:[[NSOperationQueue alloc] init]];
//    [connection start];
//    NSLog(@"%@",[NSThread currentThread]);
//    NSLog(@"---------------");

    
    //connection本身在子线程中执行
    //connection的代理方法在子线程中执行
    //在主线程中开启异步任务
    //dispatch_async是异步执行任务
    //dispatch_get_global_queue(0, 0)是一个全局的并发队列
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
//        [connection setDelegateQueue:[[NSOperationQueue alloc] init]];
//        [connection start];
        NSLog(@"%@",[NSThread currentThread]);
        
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        [connection setDelegateQueue:[[NSOperationQueue alloc] init]];
//        [connection setDelegateQueue:[NSOperationQueue mainQueue]];
        [[NSRunLoop currentRunLoop] run];
        
        
        NSLog(@"---------------");
    });
//
    
    
}

#pragma mark - UICollectionViewDataSource
//接收到服务器的响应
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"%s ----- %@",__func__,[NSThread currentThread]);
}

//接收到服务器的数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    NSLog(@"%s ----- %@",__func__,[NSThread currentThread]);
}

//接受完服务器的数据
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"%s ----- %@",__func__,[NSThread currentThread]);
}

//接受服务器数据失败
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"%s ----- %@",__func__,[NSThread currentThread]);
}

@end
