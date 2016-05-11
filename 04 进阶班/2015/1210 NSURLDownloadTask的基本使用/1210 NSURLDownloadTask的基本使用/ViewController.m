//
//  ViewController.m
//  1210 NSURLDownloadTask的基本使用
//
//  Created by 张思琦 on 15/12/10.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

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

    [self download];
}

- (void)download{
    //1 创建URLSession
    NSURLSession *session = [NSURLSession sharedSession];
    
    //2 利用URLSession创downloadTask
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/images/minion_02.png"];
    
    //url 提供下载的URL地址
    //completionHandler 回调block,用于进行下载后的操作
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //location 下载完成后数据保存的地址
        //response 响应头
        //error    错误信息
        
        //获取沙盒的cache路径
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        path = [path stringByAppendingPathComponent:response.suggestedFilename];
        NSLog(@"%@", path);
        //移动文件到沙盒的cache文件夹下
        NSFileManager *manager = [NSFileManager defaultManager];
        [manager moveItemAtURL:location toURL:[NSURL fileURLWithPath:path] error:nil];
    }];
    
    //3 启动downloadTask
    [downloadTask resume];
}

@end
