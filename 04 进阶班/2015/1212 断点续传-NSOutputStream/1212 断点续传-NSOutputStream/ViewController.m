//
//  ViewController.m
//  1212 断点续传-NSOutputStream
//
//  Created by 张思琦 on 15/12/12.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () < NSURLSessionDataDelegate >
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UIButton *continueButton;

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@property (nonatomic, strong) NSOutputStream *outputSteam;

@property (nonatomic, assign) NSUInteger currentLength;
@property (nonatomic, assign) NSUInteger totalLength;

@end

@implementation ViewController


#pragma mark - button Function Method
- (IBAction)clickStartButton:(id)sender {
    NSLog(@"%s",__func__);
    //1 创建URLSession
    //2 利用URLSession创建URLSessionDataTask
    //3 执行任务
    [self.dataTask resume];
}

- (IBAction)clickPauseButton:(id)sender {
    NSLog(@"%s",__func__);
    [self.dataTask suspend];
}

- (IBAction)clickContinueButton:(id)sender {
    NSLog(@"%s",__func__);
    [self.dataTask resume];
}


#pragma mark - NSURLSessionDataDelegate
//收到服务器响应
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    
    //创建OutputSteam用于保存数据
    
    //获取文件写入位置
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:@"minion_02.mp4"];
    NSURL *url = [NSURL fileURLWithPath:path];
    //创建OutputSteam
//    NSOutputStream *outputSteam = [[NSOutputStream alloc] initWithURL:url append:YES];
    NSOutputStream *outputSteam = [[NSOutputStream alloc] initToFileAtPath:path append:YES];
    self.outputSteam = outputSteam;
    [self.outputSteam open];
    
    //计算文件的总大小
    self.totalLength = [self fileSize] + response.expectedContentLength;
    
    //允许接受服务器的数据
    completionHandler(NSURLSessionResponseAllow);
    
}


//收到服务器数据
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    [self.outputSteam write:data.bytes maxLength:data.length];
    
    self.currentLength += data.length;
    self.progressView.progress = 1.0 * self.currentLength / self.totalLength;
    NSLog(@"%f",self.progressView.progress);
}

//下载完毕时
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    [self.outputSteam close];
    self.outputSteam = nil;
}


#pragma mark - lazy
- (NSURLSession *)session{
    if (_session == nil) {
        //会在代理方法中执行更新UI界面的操作,所以要在主线程中执行
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _session;

}

- (NSURLSessionDataTask *)dataTask{
    if (_dataTask == nil) {
        //2.1创建URL
        NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_02.mp4"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        //2.2获取已经下载文件大小
        NSInteger fileSize = [self fileSize];
        
        //2.3设置文件下载的起始位置
        NSString *range = [NSString stringWithFormat:@"bytes=%zd-", fileSize];
        [request setValue:range forHTTPHeaderField:@"Range"];
        
        _dataTask = [self.session dataTaskWithRequest:request];
        
        self.currentLength = [self fileSize];
    }
    return _dataTask;
}

#pragma mark - fileSize
- (NSUInteger)fileSize{
    //2.2获取已经下载文件大小
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:@"minion_02.mp4"];
    NSDictionary *dict = [manager attributesOfItemAtPath:path error:nil];
    NSLog(@"%@",dict[NSFileSize]);
    return [dict[NSFileSize] integerValue];

}

@end
