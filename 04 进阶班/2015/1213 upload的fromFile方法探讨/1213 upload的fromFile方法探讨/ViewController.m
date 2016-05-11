//
//  ViewController.m
//  1213 upload的fromFile方法探讨
//
//  Created by 张思琦 on 15/12/13.
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

//创建一个NSURLSessionUploadTask任务
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //1 创建URLSession
    NSLog(@"%s",__func__);
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    
    //2 创建URLSessionUploadTask
    //创建request
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/upload"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //设置请求头
    request.HTTPMethod = @"POST";
   
    //创建文件路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:@"minion_04.mp4"];
    NSURL *fileURL = [NSURL fileURLWithPath:path];
    
    
//    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request fromFile:fileURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
//    }];
    
    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request fromFile:fileURL];
    //3 启动Task
    [uploadTask resume];
    
}


#pragma mark - NSURLSessionDataDelegate
/**
 *  用于监听上传事件的方法
 *
 *  @param session                  触发该方法的session
 *  @param task                     触发该方法的task
 *  @param bytesSent                此次发送数据的总大小
 *  @param totalBytesSent           此次请求已经上传数据的总大小
 *  @param totalBytesExpectedToSend 此次请求需要上传数据的总大小
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend{
    NSLog(@"%f",1.0 * totalBytesSent / totalBytesExpectedToSend);
}
//
//
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    NSLog(@"success");
}

- (void)fuck{
    
//    //content-type为multipart/form-data时代表需要上传文件
//    [request setValue:@"multipart/form-data; boundary=----SQ" forHTTPHeaderField:@"Content-Type"];
    
    //设置请求体
    //创建二进制对象并拼接该对象
    NSMutableData *data = [NSMutableData data];
    
    //设置文件参数
    [data appendData:[@"------SQ" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    //name:对应服务端接受的字段类型
    //fileName:告诉服务端当前上传文件的名称
    [data appendData:[@"Content-Disposition: form-data; name=\"file\"; filename=\"123.xlsx\"" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [data appendData:[@"Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                      dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    NSData *imageData = UIImagePNGRepresentation([UIImage imageNamed:@"Snip20151209_7.png"]);
    [data appendData:imageData];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    //设置非文件参数
    [data appendData:[@"------SQ" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [data appendData:[@"Content-Disposition:form-data; name=\"username\"" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"zsq" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    //设置结束符号
    [data appendData:[@"------SQ--" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    

}

@end
