//
//  ViewController.m
//  1218 AFN的基本使用
//
//  Created by 张思琦 on 15/12/18.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>

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
    [self downloadWithAFN];
}

- (void)getWithSession{
    //1 创建sessionManager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //创建get请求
  
    
    /**
     *  用于发送get请求
     *  @param GET            向哪个网址发送get请求
     *  @param parameters     发送get请求时,请求中的参数
     *  success
     *  @param task           执行发送请求的任务
     *  @param responseObject 服务器返回的响应体
     *  failure
     *  @param task           执行发送请求的任务
     *  @param error          错误信息
     *
     *  @return 返回值为NSURLSessionDataTask
     */
    [manager GET:@"http://120.25.226.186:32812/login?username=520it&pwd=520it&type=JSON" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    

}


- (void)postWithSession{
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    /**
     *  用于发送get请求
     *  @param POST           向哪个网址发送POST请求
     *  @param parameters     发送POST请求时,请求中的参数
     *  success
     *  @param task           执行发送请求的任务
     *  @param responseObject 服务器返回的响应体
     *  failure
     *  @param task           执行发送请求的任务
     *  @param error          错误信息
     *
     *  @return 返回值为NSURLSessionDataTask
     */
    NSDictionary *parameters = @{
                            @"username":@"520it",
                            @"pwd":@"520it"
    };
    
    [manager POST:@"http://120.25.226.186:32812/login" parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
    manager POST:<#(nonnull NSString *)#> parameters:<#(nullable id)#> progress:<#^(NSProgress * _Nonnull uploadProgress)uploadProgress#> success:<#^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)success#> failure:<#^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)failure#>
    
}


- (void)downloadWithAFN{
    NSLog(@"%s",__func__);
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_02.mp4"]];
    
    //request:  告诉程序向哪里发送下载任务的请求
    //progress: 用于记录下载进度的
    //destination:
    //completionHandler:

    
   NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
//       @property int64_t totalUnitCount;      文件总大小
//       @property int64_t completedUnitCount;  已经下载的大小
       [downloadProgress addObserver:self forKeyPath:@"completedUnitCount" options:NSKeyValueObservingOptionNew context:nil];
       
       
    }destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //targetPath 零时数据保存的位置
        //response   服务器返回的响应体
        //block的返回值为文件保存的最终位置
        
       NSLog(@"零时文件在----%@", targetPath);
        NSString *toPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        toPath = [toPath stringByAppendingPathComponent:response.suggestedFilename];
        NSURL *url = [NSURL fileURLWithPath:toPath];
        NSLog(@"把文件移动到----%@", url);
        return url;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        //response  服务器返回的响应体
        //filePath  文件最终的保存位置
        //error     错误信息
        NSLog(@"下载文件存在----%@", filePath);
    }];
    
    [downloadTask resume];


}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    NSLog(@"%@",change);
}
 

@end
