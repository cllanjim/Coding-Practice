//
//  ViewController.m
//  1206 小文件下载
//
//  Created by 张思琦 on 15/12/6.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(44, 44, 200, 200)];
    imageView.backgroundColor = [UIColor darkGrayColor];
    self.imageView = imageView;
    [self.view addSubview:self.imageView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //小文件下载的思路
    //思路一
    //1获取url
//    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/images/minion_02.png"];
//    //2获取请求
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    //利用NSURLConnection技术发送请求
//    //3发送异步请求
//    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//        //response 响应头
//        //data 响应体
//        //connectionError 错误信息
//        UIImage *image = [UIImage imageWithData:data];
//        NSLog(@"%@",image);
//        //回到主线程进行UI更新
//        //获取主队列
//        dispatch_queue_t mainqueue = dispatch_get_main_queue();
//        dispatch_async(mainqueue, ^{
//            self.imageView.image = image;
//        });
//    }];
    
    //思路二
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/images/minion_02.png"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    self.imageView.image = image;
    

}

@end
