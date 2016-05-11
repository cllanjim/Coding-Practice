//
//  ViewController.m
//  1221 AFN使用注意事项
//
//  Created by 张思琦 on 15/12/21.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "SQHTTPSessionManager.h"

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
    //1 创建Manager
    SQHTTPSessionManager *manager = [SQHTTPSessionManager sharedSQManager];
    //2 创建GET请求
    NSDictionary *parameters = @{
                                @"username":@"520it",
                                @"pwd":@"520it"
                                };
    [manager GET:@"login" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
}

@end
