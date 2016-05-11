//
//  ViewController.m
//  1206 大文件下载
//
//  Created by 张思琦 on 15/12/6.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSURLConnectionDataDelegate>
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;


//文件长度
@property (nonatomic, assign) NSUInteger totalLength;
@property (nonatomic, assign) NSUInteger currentLength;

//文件路径
@property (nonatomic, strong) NSString *path;

////文件的操作句柄
@property (nonatomic, strong) NSFileHandle *fileHandle;


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
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_03.mp4"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection connectionWithRequest:request delegate:self];
}



#pragma mark - NSURLConnectionDataDelegate方法
//接受到服务器的响应就会调用
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"%s",__func__);
    
    //获取文件的总长度
    self.totalLength = response.expectedContentLength;
    
    //创建相应的空白文件用于保存
    //1获取文件管理者
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //2获取沙盒路径
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    //3根据响应体中的建议名称创建对应的文件路径
    NSString *fileName = response.suggestedFilename.lastPathComponent;
    NSString *path = [dir stringByAppendingPathComponent:fileName];
    self.path = path;
    //4创建文件
    if ([fileManager createFileAtPath:self.path contents:nil attributes:nil]) {
        NSLog(@"创建文件成功");
    };
    
    //创建操作句柄
    self.fileHandle = [NSFileHandle fileHandleForWritingAtPath:self.path];
    
}

//接收到服务器的数据就会调用
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    //写入文件的操作
    //1通过懒加载创建文件操作句柄
    
    //2设置写入数据的位置
    //将句柄设置在已有文件的最后位置
    [self.fileHandle seekToEndOfFile];
    
    //3写入数据
    [self.fileHandle writeData:data];
    
    //计算下载进度
    self.currentLength += data.length;
    self.progressView.progress = 1.0 * self.currentLength / self.totalLength;
    
}

//接受完数据后就会调用
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    [self.fileHandle closeFile];
    self.fileHandle = nil;
    NSLog(@"%@",self.path);
    

}

//接受到错误信息就会调用
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"Wrong Information");
}

#pragma mark - lazy 
//- (NSFileHandle *)fileHandle{
//    if (_fileHandle == nil) {
//        //在指定的操作文件中建立操作句柄
//        _fileHandle = [NSFileHandle fileHandleForWritingAtPath:self.path];
//    }
//    return _fileHandle;
//}

@end
