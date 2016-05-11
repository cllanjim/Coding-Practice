//
//  ViewController.m
//  0901 线程间的通讯
//
//  Created by 张思琦 on 15/9/1.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) NSThread *thread;

@end

@implementation ViewController

/*******************************************************************************/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //应当在子线程中完成数据的下载等耗时任务
    //创建线程
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(downladImage) object:nil];
    self.thread = thread;
    NSLog(@"%s",__func__);

    // Do any additional setup after loading the view, typically from a nib.
}

/*******************************************************************************/
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //子线程开始执行任务
    [self.thread start];
    NSLog(@"%s",__func__);

}

/*******************************************************************************/
- (void)downladImage
{
    
    
    NSLog(@"%@",[NSThread currentThread]);
    //1 获取图片网址
    
    //记录开始时间
//    NSDate *begin = [NSDate date];
    CFAbsoluteTime begin = CFAbsoluteTimeGetCurrent();
    CFAbsoluteTime end = CFAbsoluteTimeGetCurrent();
    NSTimeInterval gap = end - begin;
    
    NSURL *url = [[NSURL alloc] initWithString:@"http://fw.kelamayi.com.cn/uploadfile/2013/0710/20130710113014225.jpg"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    
    //记录结束时间
//    NSDate *end = [NSDate date];
    //计算开始与结束的时间间隔
//    NSTimeInterval gap =[end timeIntervalSinceDate:begin];
    NSLog(@"%f", gap);
    //不要再子线程中更新UI,容易出现问题
    /*******************************/
    //self.imageView.image = image;
    /*******************************/
    
    //将更新UI的任务交给主线程完成
    /*
     waitUntilDone:
     YES: 如果传入YES, 那么会等待updateImage方法执行完毕, 才会继续执行后面的代码
     NO:  如果传入NO, 那么不会等待updateImage方法执行完毕, 就可以继续之后后面的代码
     */
    //方法一 开发中常用的方法
    [self.imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:YES];
    //方法二 常规思路,还需要写一个具体的方法,较为麻烦
    [self performSelectorOnMainThread:@selector(updateImageView:) withObject:image waitUntilDone:YES];
    //方法三
    [self performSelector:@selector(updateImageView:) onThread:[NSThread mainThread] withObject:image waitUntilDone:YES];
    
    NSLog(@"%s",__func__);
    
}

/*******************************************************************************/
- (void)updateImageView:(UIImage *)image
{
    self.imageView.image = image;
    NSLog(@"%@",[NSThread currentThread]);
    NSLog(@"%s",__func__);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
