//
//  ViewController.m
//  0903 GCD的常用方法
//
//  Created by 张思琦 on 15/9/3.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
/********************** 常用的延迟方法 ************************/
    
    /*
     + (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo;
     (NSTimeInterval)ti     指时间间隔
     (id)aTarget            执行者
     (SEL)aSelector         执行的方法
     userInfo:(id)userInfo  传递的参数
     repeats:(BOOL)yesOrNo  是否重复
     */
//    [NSTimer scheduledTim erWithTimeInterval:2 target:self selector:@selector(doWork) userInfo:nil repeats:YES];
    
    /*
     - (void)performSelector:(SEL)aSelector withObject:(id)anArgument afterDelay:(NSTimeInterval)delay;
     (SEL)aSelector         执行的方法
     (id)anArgument         方法的参数
     (NSTimeInterval)delay  延迟时间
     */
//    [self performSelector:@selector(doWork) withObject:nil afterDelay:2];

    
    
    /*
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     code to be executed after a specified delay
     });
     DISPATCH_TIME_NOW          开始的时间
     delayInSeconds             延迟的时间
     dispatch_get_main_queue    执行任务的队列
     block中的内容               需要执行的任务
     */
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
//        [self doWork];
//    });
   
/********************** 一次性代码 ************************/
    /*
     static dispatch_once_t onceToken;      表示代码块的标签
     block中的内容                           需要执行的任务
     */
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        NSLog(@"Hello World");
//    });

/********************** 快速迭代 ************************/

    /*
     size_t iterations:         需要遍历几次
     dispatch_queue_t queue:    决定第三个参数的block在哪个线程中执行
     ^(size_t) {code}:          block为回掉内容,size_t为遍历的索引值
     */
    /*
     dispatch_apply(size_t iterations, dispatch_queue_t queue, ^(size_t) {
     code
     })
     */
    
//    //1 获取原始文件夹的路径
//    NSString *fromFilePath = @"/Users/SketchK/Desktop/a";
//    //2 获取目标文件夹的路径
//    NSString *toFilePath = @"/Users/SketchK/Desktop/b";
//    
//    //3 获取原始文件夹中所有文件的名称
//    //subpathsAtPath 是获取目标文件夹下所有文件名
//    NSArray *array = [[NSFileManager defaultManager] subpathsAtPath:fromFilePath];
//    
//    //3 开始拷贝文件
//    dispatch_apply(array.count, dispatch_get_global_queue(0, 0), ^(size_t index) {
//        NSString *fileName = array[index];
//        
//        //3.1 原始文件夹中文件的路径
//        //stringByAppendingPathComponent 给指定路径后面加上传入的参数
//        NSString *fromName = [fromFilePath stringByAppendingPathComponent:fileName];
//    
//        //3.2 目标文件夹中文件的路径
//        NSString *toName = [toFilePath stringByAppendingPathComponent:fileName];
//    
//        //3.3 拷贝文件
//        [[NSFileManager defaultManager] moveItemAtPath:fromName toPath:toName error:nil];
//        
//    });
    
    /********************** 栅栏方法 ************************/
  
//    //1 下载图片1
//    //1.1创建并发线程
//    dispatch_queue_t queue1 = dispatch_queue_create("ZSQ", DISPATCH_QUEUE_CONCURRENT);
//    //1.2异步方式执行任务
//   __block UIImage *image1 = nil;
//    dispatch_async(queue1, ^{
//        NSURL *url1 = [NSURL URLWithString:@"http://images.china.cn/attachement/jpg/site1000/20100511/d8d38508cfdf0d5308f13f.jpg"];
//        NSData *data1 = [NSData dataWithContentsOfURL:url1];
//        image1 = [UIImage imageWithData:data1];
//    });
//    
//    //2 下载图片2
//    __block UIImage *image2 = nil;
//    dispatch_async(queue1, ^{
//        NSURL *url2 = [NSURL URLWithString:@"http://gb.cri.cn/mmsource/images/2011/01/19/57/17258029747888710361.jpg"];
//        NSData *data2 = [NSData dataWithContentsOfURL:url2];
//        image2 = [UIImage imageWithData:data2];
//    });
//    
//    //3 合成图片
//    dispatch_barrier_async(queue1, ^{
//        
//        //1 开启图片上下文
//        UIGraphicsBeginImageContext(CGSizeMake(200,200));
//        //2 将第一张图片画上去
//        [image1 drawInRect:CGRectMake(0, 0, 100, 100)];
//        //3 将第二张图片画上去
//        [image2 drawInRect:CGRectMake(100, 0, 100, 100)];
//        //4 从上下文中获取图片
//        UIImage *image0 = UIGraphicsGetImageFromCurrentImageContext();
//        //5 关闭上下文
//        UIGraphicsEndImageContext();
//        
//        //回到主线程中刷新UI
//        dispatch_queue_t mainquene = dispatch_get_main_queue();
//        dispatch_async(mainquene, ^{
//            self.imageView.image = image0;
//        });
//    });
    
    
    
    /********************** 队列组方法 ************************/

    //1 下载图片1
    //1.1创建并发线程
    dispatch_queue_t queue1 = dispatch_queue_create("ZSQ", DISPATCH_QUEUE_CONCURRENT);
    __block UIImage *image1 = nil;
    __block UIImage *image2 = nil;
    
    //创建队列组
    dispatch_group_t group = dispatch_group_create();
    
    //1.2异步方式执行任务
    dispatch_group_async(group, queue1, ^{
        NSURL *url1 = [NSURL URLWithString:@"http://images.china.cn/attachement/jpg/site1000/20100511/d8d38508cfdf0d5308f13f.jpg"];
        NSData *data1 = [NSData dataWithContentsOfURL:url1];
        image1 = [UIImage imageWithData:data1];
    });
    
    //2 下载图片2
    dispatch_group_async(group, queue1, ^{
        NSURL *url2 = [NSURL URLWithString:@"http://gb.cri.cn/mmsource/images/2011/01/19/57/17258029747888710361.jpg"];
        NSData *data2 = [NSData dataWithContentsOfURL:url2];
        image2 = [UIImage imageWithData:data2];
    });
    
    //3 合成图片
    // 3.开启一个新的线程, 合成图片
    // 只要将队列放到group中, 队列中的任务执行完毕, group就会发出一个通知
    dispatch_group_notify(group, queue1, ^{
        
        //1 开启图片上下文
        UIGraphicsBeginImageContext(CGSizeMake(200,200));
        //2 将第一张图片画上去
        [image1 drawInRect:CGRectMake(0, 0, 100, 100)];
        //3 将第二张图片画上去
        [image2 drawInRect:CGRectMake(100, 0, 100, 100)];
        //4 从上下文中获取图片
        UIImage *image0 = UIGraphicsGetImageFromCurrentImageContext();
        //5 关闭上下文
        UIGraphicsEndImageContext();
        
        //回到主线程中刷新UI
        dispatch_queue_t mainquene = dispatch_get_main_queue();
        dispatch_async(mainquene, ^{
            self.imageView.image = image0;
        });
    });
    
}

- (void)doWork{
    NSLog(@"Hello World");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
