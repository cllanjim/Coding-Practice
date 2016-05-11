//
//  ViewController.m
//  1211 NSURLDownloadTask使用代理进行下载
//
//  Created by 张思琦 on 15/12/11.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLSessionDownloadDelegate>
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;


@property (nonatomic, strong) NSData *resumeData;

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

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
////    [downloadTask resume];
//}

#pragma mark - button Function
//开始下载
- (IBAction)startButton:(id)sender {
    NSLog(@"%s",__func__);

    //1创建NSURLSession
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    self.session = session;
    
    //2根据NSURLSession创建DownLoadTask
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_02.mp4"];
    
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url];
    self.downloadTask = downloadTask;
    
    //3启动任务
    [self.downloadTask resume];
}

//暂停下载
- (IBAction)pauseButton:(id)sender {
    NSLog(@"%s",__func__);
    //暂停
//    [self.downloadTask suspend];
    //取消下载时不保留数据
//    [self.downloadTask cancel];
    //取消下载时保留数据
    [self.downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        self.resumeData = resumeData;
    }];
    
}

//继续下载
- (IBAction)continueButton:(id)sender {
    NSLog(@"%s",__func__);

    //继续
//    [self.downloadTask resume];
    
//    读取已经保存的下载数据开始下载
    self.downloadTask = [self.session downloadTaskWithResumeData:self.resumeData];
    [self.downloadTask resume];
}

#pragma mark - NSURLSessionDownloadDelegate
//当从服务器端获取数据时,调用该方法
//session 触发该方法的NSURLSession对象
//downloadTask 触发该方法的downloadTask对象
//bytesWritten  本次写入到本地的数据大小
//totalBytesWritten 已经写入到本地的数据大小
//totalBytesExpectedToWrite  从服务端要下载数据的总大小
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    
    NSLog(@"didWriteData %f", 1.0 * totalBytesWritten / totalBytesExpectedToWrite);
    self.progressView.progress = 1.0 * totalBytesWritten / totalBytesExpectedToWrite;
    
    
}


//当暂停下载后重新开启下载时调用
//session 触发该方法的NSURLSession对象
//downloadTask 触发该方法的downloadTask对象
//fileOffset 现有文件的大小
//expectedTotalBytes 从服务器端要下载数据的总大小
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes{
    NSLog(@"didResumeAtOffset");
}

//当从服务器端获取数据完毕时调用
//session 触发该方法的NSURLSession对象
//downloadTask 触发该方法的downloadTask对象
//location 文件暂时保存的地址
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    
    NSLog(@"didFinishDownloadingToURL");
    
    //获取app的cache文件夹路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName = downloadTask.response.suggestedFilename;
    path = [path stringByAppendingPathComponent:fileName];
    
    //创建文件管理者
    NSFileManager *manager = [NSFileManager defaultManager];
    //移动文件
    [manager moveItemAtURL:location toURL:[NSURL fileURLWithPath:path] error:nil];
    
}


//请求完毕时调用
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    NSLog(@"didCompleteWithError");

}

@end
