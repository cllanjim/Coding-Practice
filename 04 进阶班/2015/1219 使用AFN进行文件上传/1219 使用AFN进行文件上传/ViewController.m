//
//  ViewController.m
//  1219 使用AFN进行文件上传
//
//  Created by 张思琦 on 15/12/19.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface ViewController ()
//@property (weak, nonatomic) IBOutlet UIImageView *imageView;

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

    [self uploadWithAFN1];
    
}


- (void)uploadWithPOST{
    //1 创建AFN管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //2 发送POST请求
//    username=520it&pwd=520it&type=JSON
    NSDictionary *parameters = @{
                                 @"username":@"520it",
                                 };
    //POST为接受POST请求的服务器地址
    //parameters为发送POST请求时附带的参数
    //constructingBodyWithBlock为上传数据的回调函数
    //progress为上传进度
    //success发送请求成功时的回调block
    //failure发送请求失败时的回调block
    
    [manager POST:@"http://120.25.226.186:32812/upload" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
//        //方式1
//        //fileURL 为上传文件的URL地址
//        //name为服务器端用于接受数据的参数
        NSString *filePath = [NSString stringWithFormat:@"/Users/SketchK/Desktop/Snip20151219_1.png"];
        NSURL *fileURL = [NSURL fileURLWithPath:filePath];
        [formData appendPartWithFileURL:fileURL name:@"file" error:nil];
//
//        //方式2
//        NSString *filePath = [NSString stringWithFormat:@"/Users/SketchK/Desktop/Snip20151219_1.png"];
//        NSURL *fileURL = [NSURL fileURLWithPath:filePath];
//        [formData appendPartWithFileURL:fileURL name:@"file" fileName:@"Snip20151219_1.png" mimeType:@"image/png" error:nil];
//
//        //方式3
//        //data为用于上传的二进制数据
//        //name为服务器端用于接受数据的参数
//        NSData *data = [NSData dataWithContentsOfFile:@"/Users/SketchK/Desktop/Snip20151219_1.png"];
//        [formData appendPartWithFileData:data name:@"file" fileName:@"Snip20151219_1.png" mimeType:@"image/png"];
        
        //方式4 无法使用
//        NSData *data = [NSData dataWithContentsOfFile:@"/Users/SketchK/Desktop/Snip20151219_1.png"];
//        [formData appendPartWithFormData:data name:@"file"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"上传成功!");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传失败!");
    }];

}



- (void)uploadWithAFN1{
    

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://120.25.226.186:32812/upload"]];
    request.HTTPMethod = @"POST";
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"123" ofType:@"png"];
    NSURL *fileURL = [NSURL fileURLWithPath:path];
    
   
    NSURLSessionUploadTask *task = [manager uploadTaskWithRequest:request fromFile:fileURL progress:nil
    completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"Success: %@ %@", response, responseObject);
        }
    }];
    
    [task resume];
    
}

//- (void)uploadWithAFN2{
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    
//    [manager uploadTaskWithRequest:<#(nonnull NSURLRequest *)#> fromData:<#(nullable NSData *)#> progress:<#^(NSProgress * _Nonnull uploadProgress)uploadProgressBlock#> completionHandler:<#^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error)completionHandler#>];
//}

@end
