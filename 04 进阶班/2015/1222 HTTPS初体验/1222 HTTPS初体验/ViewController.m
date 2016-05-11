//
//  ViewController.m
//  1222 HTTPS初体验
//
//  Created by 张思琦 on 15/12/22.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSURLSessionDataDelegate>

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
    //1 创建NSURLSession对象
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    //2 创建NSURLSessionDataTask对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.apple.com"]];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request];
    
    //3 启动Task对象
    [task resume];
}

#pragma mark - NSURLSessionDataDelegate
//session 触发方法的session
//challenge 包含授权信息的对象
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
    //这个block中要返回disposition(对待)和credential(证书对象)
        //disposition是对授权信息的几种处理方式
            //NSURLSessionAuthChallengeUseCredential = 0,   信任证书
            //NSURLSessionAuthChallengePerformDefaultHandling = 1, 执行默认操作,不设置代理,证书参数被忽略
            //NSURLSessionAuthChallengeCancelAuthenticationChallenge = 2 取消请求,证书被忽略
            //NSURLSessionAuthChallengeRejectProtectionSpace = 3,   拒绝请求
        //credential 授权的证书
    //1 判断服务器返回的证书是否为可信证书
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
    //2 根据判断结果做出相应的操作
        //获取证书
        NSLog(@"Hello, World");
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        //这个block中要返回disposition(对授权信息的处理方式)和credential(证书对象)
        completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{

}

//当获得服务器响应时调用该方法
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler{
    completionHandler(NSURLSessionResponseAllow);
}

//当获得服务器的数据时调用该方法
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{

}

//当从服务器获取完数据时调用该方法
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{

}
@end
