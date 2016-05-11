//
//  ViewController.m
//  1210 NSURLSessionDownloadTask
//
//  Created by 张思琦 on 15/12/10.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLSessionDataDelegate>

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
    [self download];
}

- (void)download{
    //1创建URLSession
    //Configuration  全局配置参数
    //delegate 代理者
    //delegateQueue 代理在哪个线程中执行
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    
    //2利用URLSession创建Task
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_01.mp4"];
    //启动什么类型的sessionTask就遵守什么类型的协议
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url];
    //3执行Task
    [dataTask resume];
    
}

#pragma mark - NSURLSessionDataDelegate
//接受到服务器的响应

//session 触发该方法的URLSession对象
//dataTask 触发该方法的URLSessionDataTask对象
//response 服务器返回的请求头
//completionHandler 用于控制获得服务器响应后的具体操作
//默认为取消任务
//NSURLSessionResponseCancel = 0,          /* 取消任务 */
//NSURLSessionResponseAllow = 1,           /* 允许接受数据 */
//NSURLSessionResponseBecomeDownload = 2,  /* 转换为下载任务 */
//NSURLSessionResponseBecomeStream         /* 转换为steam任务 */


- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler{
    NSLog(@"%s---%@", __func__, [NSThread currentThread]);
    //默认情况下系统不会接受服务器返回的数据,所以不会调用其他代理方法
    //如果需要接受数据,必须在接收到服务器响应的时候,告诉系统我们要接受数据
    completionHandler(NSURLSessionResponseAllow);
    
}

//接受到服务器的数据
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    NSLog(@"%s---%@", __func__, [NSThread currentThread]);
}

//
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    NSLog(@"%s---%@", __func__, [NSThread currentThread]);
}
@end
