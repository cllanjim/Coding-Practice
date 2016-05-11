//
//  ViewController.m
//  1206 大文件下载(内存)
//
//  Created by 张思琦 on 15/12/6.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSURLConnectionDataDelegate>
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

//长度
@property (nonatomic, assign) NSUInteger currentLength;
@property (nonatomic, assign) NSUInteger totalLength;

//用于保存二进制数据的属性
@property (nonatomic, strong) NSMutableData *data;

@property (nonatomic, strong) NSString *path;

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

#pragma mark - NSURLConnectionDataDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    //创建对应的文件
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName = response.suggestedFilename;
    path = [path stringByAppendingPathComponent:fileName];
    
    self.path = path;
    
    NSLog(@"%@",self.path);
    
    //计算文件长度
    self.totalLength = response.expectedContentLength;
    
    //初始化data数据
    self.data = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [self.data appendData:data];
    
    self.currentLength += data.length;
    self.progressView.progress = 1.0 * self.currentLength / self.totalLength;
    
    
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    [self.data writeToFile:self.path atomically:YES];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{

}



@end
