//
//  ViewController.m
//  1206 文件断点下载
//
//  Created by 张思琦 on 15/12/6.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLConnectionDataDelegate>
//文件大小
@property (nonatomic, assign) NSUInteger currentLength;
@property (nonatomic, assign) NSUInteger totalLength;
//文件路径
@property (nonatomic, strong) NSString *filePaht;
//请求头
@property (nonatomic, strong) NSMutableURLRequest *request;
//文件保存路径
@property (nonatomic, strong) NSString *filePath;


//输出流
@property (nonatomic, strong) NSOutputStream *outputStream;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.progressView.progress = 0;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_03.mp4"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    self.request = request;

    NSFileManager *fileManger = [NSFileManager defaultManager];
    NSString *path = [self getFilePathWihtFileName:@"minion_03.mp4"];
    NSDictionary *dict = [fileManger attributesOfItemAtPath:path error:nil];
    NSUInteger localLength = [dict[NSFileSize] integerValue];

    
    //设置请求头
    //以下的代码的作用是让程序根据当前文件的大小继续进行下载
    
    //NSFileSize返回NSNumber对象
    //integerValue返回NSInteger
    NSString *range = [NSString stringWithFormat:@"bytes:%zd-",localLength];
    //range中
    //bytes = 0 - 99 表示头99字节
    //bytes = 100 - 199 表示第二个99字节
    //bytes = - 99 表示最后99字节
    //bytes = 99 - 表示99以后的字节
    //bytes = 0 - 0,  -1 第一个和最后一个字节
    //bytes = 50 - 60,70 - 90 表示同时指定几个范围
    [self.request setValue:range forHTTPHeaderField:@"Range"];
    [NSURLConnection connectionWithRequest:self.request delegate:self];

}


#pragma mark - NSURLConnectionDataDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{

    NSString *fileName = response.suggestedFilename.lastPathComponent;
    NSString *path = [self getFilePathWihtFileName:fileName];
    self.filePath = path;
    
    //初始化输出流
    self.outputStream = [NSOutputStream outputStreamToFileAtPath:self.filePath append:YES];
    [self.outputStream open];
    
    //计算总大小
    //总大小 = 本地文件大小 + 剩余文件大小
    //当使用断点下载后,expectedContentLength属性代表剩余文件大小
    self.totalLength = response.expectedContentLength;
    
    //获取本地文件大小
    NSUInteger localLength = [self getFileSizeWithFilePath:self.filePath];
    //当使用断点下载后,expectedContentLength属性代表剩余文件大小
    //计算总大小    总大小 = 剩余文件大小 +  本地文件大小
    self.totalLength = response.expectedContentLength + localLength;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    //写入数据
    [self.outputStream write:data.bytes maxLength:data.length];
    
    //计算下载进度
    //获取本地文件大小
    NSUInteger localLength = [self getFileSizeWithFilePath:self.filePath];
    //计算当前下载大小  当前下载大小 = 当前获取的数据大小 + 本地文件大小
    self.currentLength = data.length + localLength;
    self.progressView.progress = 1.0 * self.currentLength / self.totalLength;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [self.outputStream close];
    self.outputStream = nil;
    NSLog(@"%s", __func__);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
}

- (NSString *)getFilePathWihtFileName:(NSString *)fileName{
    //1获取沙盒路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    //3拼接生成对应的文件存放路径
    path = [path stringByAppendingPathComponent:fileName];
    return path;
}

- (NSInteger )getFileSizeWithFilePath:(NSString *)filePath{
    NSFileManager *fileManger = [NSFileManager defaultManager];
    NSDictionary *dict = [fileManger attributesOfItemAtPath:self.filePath error:nil];
    return [dict[NSFileSize] integerValue];
}
@end
