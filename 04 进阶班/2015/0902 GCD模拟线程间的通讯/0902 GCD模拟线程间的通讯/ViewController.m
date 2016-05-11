//
//  ViewController.m
//  0902 GCD模拟线程间的通讯
//
//  Created by 张思琦 on 15/9/2.
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
    //1 创建一个线程
    dispatch_queue_t queue0 = dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0);
    
    //2 以异步方式执行耗时任务
    dispatch_async(queue0, ^{
        NSURL *url = [[NSURL alloc] initWithString:@"http://fw.kelamayi.com.cn/uploadfile/2013/0710/20130710113014225.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        
        //在主线程中更新UI
        //1 获取主线程
        dispatch_queue_t queue1  = dispatch_get_main_queue();
        //2
        //同步方式执行更新UI界面
        //系统会在更新UI完后才执行        NSLog(@"直接执行线程中后面的代码");

        dispatch_sync(queue1, ^{
            self.imageView.image = image;
            NSLog(@"先执行block");
            NSLog(@"先执行block");
            NSLog(@"先执行block");
            NSLog(@"先执行block");

        });
        
        //异步方式执行更新UI界面
        //系统不会等UI更新完就直接执行        NSLog(@"直接执行线程中后面的代码");

//        dispatch_async(queue, ^{
//            self.imageView.image = image;
//            NSLog(@"先执行block");
//            NSLog(@"先执行block");
//            NSLog(@"先执行block");
//            NSLog(@"先执行block");
//            
//        });
        
        NSLog(@"直接执行线程中后面的代码");
        
    });

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
