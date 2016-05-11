//
//  ViewController.m
//  1210 NSURLSessionDataTask的基本使用
//
//  Created by 张思琦 on 15/12/10.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

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
//    [self getWihtRequest];
    [self getWithURL];
}



- (void)getWihtRequest{
    //1创建NSURLSession
    NSURLSession *session = [NSURLSession sharedSession];
    
    //2利用NSURLSession对象创建Task
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/login?username=520it&pwd=520it&type=JSON"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //request 为网络请求
    //completionHandler 为回调block
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //data为响应体
        //response为响应头
        //error为错误信息
        NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSLog(@"%ld", httpResponse.statusCode);
    }];
    //3执行Task
    [task resume];
    
}

- (void)getWithURL{
    //1创建NSURLSession
    NSURLSession *session = [NSURLSession sharedSession];
    
    //2利用NSURLSession创建Task
   NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:@"http://120.25.226.186:32812/login?username=520it&pwd=520it&type=JSON"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSLog(@"%ld", httpResponse.statusCode);
    }];
    //3执行Task任务
    [task resume];
}

- (void)post{
    //1创建NSURLSession
    NSURLSession *session = [NSURLSession sharedSession];
    //2根据NSURLSession创建Task
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/login"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //设置请求的类型
    request.HTTPMethod = @"POST";
    //设置请求的内容
    request.HTTPBody = [@"username=520it&pwd=520it&type=JSON" dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSLog(@"%ld", httpResponse.statusCode);
    }];
    //3执行任务
    [task resume];
    
    
}


@end
