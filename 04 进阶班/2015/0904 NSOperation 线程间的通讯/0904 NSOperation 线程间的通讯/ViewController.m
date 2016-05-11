//
//  ViewController.m
//  0904 NSOperation 线程间的通讯
//
//  Created by 张思琦 on 15/9/4.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __block UIImage *image1;
    __block UIImage *image2;

    
    //1 创建队列
    NSOperationQueue *queue1 = [[NSOperationQueue alloc] init];
    
    //2 创建NSOperation并添加任务
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        //1 获取url
        NSURL *url = [[NSURL alloc] initWithString:@"http://www.ibayue.com/images/fileup/201411/20141103150824.jpg"];
        
        //2 获取data
        NSData *data = [[NSData alloc] initWithContentsOfURL:url];
        
        //3 获取图片
        image1 = [UIImage imageWithData:data];
        
    }];
    
    
    //1 创建队列
    NSOperationQueue *queue2 = [[NSOperationQueue alloc] init];
    
    //2 创建NSOperation并添加任务
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        //1 获取url
        NSURL *url = [[NSURL alloc] initWithString:@"http://www.ibayue.com/images/fileup/201411/20141103150824.jpg"];
        
        //2 获取data
        NSData *data = [[NSData alloc] initWithContentsOfURL:url];
        
        //3 获取图片
        image2 = [UIImage imageWithData:data];
        
    }];
    
    
    
    //1 创建队列
    NSOperationQueue *queue3 = [NSOperationQueue mainQueue];
    
    //2 创建NSOperation并添加任务
    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
        
        //1 开启图形上下文
        UIGraphicsBeginImageContext(CGSizeMake(200, 200));
        
        //2 绘制图片到上下文
        [image1 drawInRect:CGRectMake(0, 0, 100, 100)];
        [image2 drawInRect:CGRectMake(100, 0, 100, 100)];
        
        //3 获取图片
        UIImage *new = UIGraphicsGetImageFromCurrentImageContext();
        
        //4 关闭上下文
        UIGraphicsEndImageContext();
        
        self.imageView.image = new;
        
        
    }];
    
    //添加依赖关系
    [operation3 addDependency:operation1];
    [operation3 addDependency:operation2];
    
    
    operation3.completionBlock = ^(){
        NSLog(@"I'm done");
    };
    [operation3 setCompletionBlock:^{
        NSLog(@"I'm done");
    }];
    
    
    //3 添加NSoperation到队列中
    [queue1 addOperation:operation1];
    [queue2 addOperation:operation2];
    [queue3 addOperation:operation3];
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
