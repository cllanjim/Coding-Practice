//
//  ViewController.m
//  1206 大文件下载(NSOutputStream)
//
//  Created by 张思琦 on 15/12/6.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSURLConnectionDataDelegate>
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (nonatomic, assign) NSUInteger currentLength;
@property (nonatomic, assign) NSUInteger totalLength;
@property (nonatomic, strong) NSString *filePath;
//输出流
@property (nonatomic, strong) NSOutputStream *outputStream;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_03.mp4"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

#pragma mark - NSURLConnectionDataDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    //获取文件长度
    self.totalLength = response.expectedContentLength;
    
    //获取文件名路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName = response.suggestedFilename;
    self.filePath = [path stringByAppendingString:fileName];
    
    //初始化outputStream
    self.outputStream = [NSOutputStream outputStreamToFileAtPath:self.filePath append:YES];
    //打开输出流
    [self.outputStream open];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    //写入数据
    [self.outputStream write:data.bytes maxLength:data.length];
    
    //计算进度
    self.currentLength += data.length;
    self.progressView.progress = 1.0 * self.currentLength / self.totalLength;

}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [self.outputStream close];
    self.outputStream = nil;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{

}

@end
