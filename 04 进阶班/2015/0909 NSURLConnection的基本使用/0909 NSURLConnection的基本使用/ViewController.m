//
//  ViewController.m
//  0909 NSURLConnection的基本使用
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
    // Do any additional setup after loading the view, typically from a nib.
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    //1 创建URL
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/login"];
    
    //2 创建Request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //设置请求方式
    request.HTTPMethod = @"POST";
    //设置请求体
    //请求体中不用设置?
    request.HTTPBody = [@"username=520it&pwd=520it&type=JSON" dataUsingEncoding:NSUTF8StringEncoding];
    
    //3 创建Connection
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    }];
    
    
    
}


- (void)asynRequest{
    //点击屏幕执行任务
    //1 创建URL
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/login?username=520it&pwd=520it&type=JSON"];
    
    //2 创建Request
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //3 创建Connection
    
    //第一个参数: 需要请求的对象
    //第二个参数: 回调block的队列, 决定了block在哪个线程中执行
    //第三个参数: 回调block
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        //response          响应头
        //data              响应体
        //connectionError   错误信息
        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        NSLog(@"%@",[NSThread currentThread]);
    }];


}

- (void)synRequest{
    //1 创建URL
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/login?username=520it&pwd=520it&type=JSON"];
    
    //2 创建URLRequest
    //默认情况下是NSURLRequest是GET请求
    //默认情况下NSURLRequest会自动给我们设置好请求头
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //3 创建URLConnection
    //第一个参数: 需要请求的对象
    //第二个参数: 服务返回给我们的响应头信息
    //第三个参数: 错误信息
    //用来接受返回的响应头
    NSURLResponse *rp1 = nil;
    //返回值: 服务器返回给我们的响应体
    //同步方法会使得当前线程按照顺序依次进行
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&rp1 error:nil];
    //响应体的真实类型为NSHTTPURLResponse
    NSHTTPURLResponse *rp = (NSHTTPURLResponse *)rp1;
    
    
    //allHeaderFields为响应头的所有信息
    NSLog(@"%@",rp.allHeaderFields);
    //statusCode为响应头的状态码
    NSLog(@"%ld",rp.statusCode);
    //expectedContentLength为文件预期大小
    NSLog(@"%lld",rp.expectedContentLength);
    
    NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
