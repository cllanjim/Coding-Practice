//
//  ViewController.m
//  1212 断点续传 - NSFileHandle
//
//  Created by 张思琦 on 15/12/12.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSURLSessionDataDelegate>
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UIButton *continueButton;

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@property (nonatomic, assign) NSUInteger currentLength;
@property (nonatomic, assign) NSUInteger totalLength;

@property (nonatomic, strong) NSFileHandle *fileHandle;

@end

@implementation ViewController

- (IBAction)clickStartButton:(id)sender {
    //1创建URLSession
    //2创建URLSessionTask
    //3启动任务
    [self.dataTask resume];
}
- (IBAction)pauseButton:(id)sender {
    [self.dataTask suspend];
}

- (IBAction)continueButton:(id)sender {
    [self.dataTask resume];
}


- (NSURLSession *)session{
    if (_session == nil) {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _session;
}

- (NSURLSessionDataTask *)dataTask{
    if (_dataTask == nil) {
        //创建NSURLRequest
        NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_04.mp4"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        //设置Request的Range属性
        //1获取本地文件大小
        self.currentLength = [self fileSize];
        //设置Request的Range属性
        NSString *range = [NSString stringWithFormat:@"bytes=%zd-", [self fileSize]];
        //setValue:forHTTPHeaderField:方法
        [request setValue:range forHTTPHeaderField:@"Range"];
        
        //获取文件写入位置
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        path = [path stringByAppendingPathComponent:@"minion_04.mp4"];
        NSLog(@"%@",path);
        
      
        
        _dataTask = [self.session dataTaskWithRequest:request];
    }
    return _dataTask;
    
}


#pragma mark - fileSize
- (NSUInteger)fileSize{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:@"minion_04.mp4"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *dict = [fileManager attributesOfItemAtPath:path error:nil];
    NSLog(@"%ld", [dict[NSFileSize] integerValue]);
    return [dict[NSFileSize] integerValue];
}

#pragma mark - NSURLSessionDataDelegate
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    //获取文件写入位置
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:@"minion_04.mp4"];
    NSLog(@"%@",path);
    
    //判断文件是否存在
    NSFileManager *fileManager = [NSFileManager defaultManager];

    if([fileManager fileExistsAtPath:path] == NO ){
        [fileManager createFileAtPath:path contents:nil attributes:nil];
    }

    
    self.fileHandle = [NSFileHandle fileHandleForWritingAtPath:path];
    
    //计算文件总大小
    self.totalLength = [self fileSize] + response.expectedContentLength;
    
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    //将操作句柄放置到指定文件的后部
    [self.fileHandle seekToEndOfFile];
    //开始写入数据
    [self.fileHandle writeData:data];
    //计算下载进度
    self.currentLength += data.length;
    self.progressView.progress = 1.0 * self.currentLength / self.totalLength;
    NSLog(@"%f",self.progressView.progress);
    
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
 {
     [self.fileHandle closeFile];
     self.fileHandle = nil;
}

@end
