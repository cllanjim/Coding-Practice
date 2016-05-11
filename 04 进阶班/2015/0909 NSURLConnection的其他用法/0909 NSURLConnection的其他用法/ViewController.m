//
//  ViewController.m
//  0909 NSURLConnection的其他用法
//
//  Created by 张思琦 on 15/9/10.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSURLConnectionDataDelegate>

@property (nonatomic, assign)NSUInteger totalLength; /**< <#数字属性#> */
@property (nonatomic, assign)NSUInteger currentLength;

@end

@implementation ViewController


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //使用NSURLConnection
    
    //1 创建URL
        NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_01.mp4"];
    
    //2 创建Request
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //3 创建Connection
    //成为NSURLConnection的代理，最好遵守NSURLConnectionDataDelegate协议
    
    //构造方法
    //方法一
    // 只要调用alloc/initWithRequest, 系统会自动发送请求
    NSURLConnection *connection1 = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    //方法二
    // startImmediately: 如果传递YES, 系统会自动发送请求; 如果传递NO, 系统不会自动发送请求
    //NSURLConnection *connection2  = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
    //[connection2 start];
    
    //工厂方法
    //方法三
    //[NSURLConnection connectionWithRequest:request delegate:self];
}

#pragma mark - NSURLConnectionDataDelegate
//当接收到服务器响应时
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    //response是响应头
    self.totalLength = response.expectedContentLength;
    NSLog(@"%zd",self.totalLength);
}

//当接收到服务器的数据时
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    self.currentLength += data.length;
    NSLog(@"%zd",self.currentLength);
    

}

//当接受完服务器的数据时
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{

    NSLog(@"%s",__func__);
}

//当接受数据失败
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{

}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
