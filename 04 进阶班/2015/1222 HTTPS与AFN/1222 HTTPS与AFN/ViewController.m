//
//  ViewController.m
//  1222 HTTPS与AFN
//
//  Created by 张思琦 on 15/12/22.
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
    //创建一个AFN请求
    NSLog(@"%s",__func__);
    //1 创建AFN管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //2 发送GET请求
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.alipay.com"]];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSLog(@"success");
        NSLog(@"%@",responseObject);
    }];
    [dataTask resume];
    

}


@end
