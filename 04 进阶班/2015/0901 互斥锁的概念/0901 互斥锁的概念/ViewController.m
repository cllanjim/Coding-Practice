//
//  ViewController.m
//  0901 互斥锁的概念
//
//  Created by 张思琦 on 15/9/1.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSThread *thread1;
@property (nonatomic, strong) NSThread *thread2;
@property (nonatomic, strong) NSThread *thread3;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) id lock;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lock = [NSArray new];
    //设定票数为100
    self.count = 100;
    //创建3个售票员
    NSThread *thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    NSThread *thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    NSThread *thread3 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    thread1.name = @"售票员1";
    thread2.name = @"售票员2";
    thread3.name = @"售票员3";
    self.thread1 = thread1;
    self.thread2 = thread2;
    self.thread3 = thread3;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //开启线程
    [self.thread1 start];
    [self.thread2 start];
    [self.thread3 start];
}

//- (void)saleTicket{
//    
//    NSLog(@"欢迎光临");
//    @synchronized(self){
//    for (NSInteger count = self.count; count > 0; count--)
//            if (count > 1){
//                [NSThread sleepForTimeInterval:0.1];
//                self.count = count - 1;
//                NSLog(@"%@卖了一张票,还剩%zd张票", [NSThread currentThread].name, self.count);
//            }else{
//                NSLog(@"票卖完了");
//                return;
//            }
//        }
//}

- (void)saleTicket
{
    while (1) {
        
        NSLog(@"欢迎光临");
        
        @synchronized(self){ // 锁住
            
            // 1.查询剩余的票数
            NSUInteger count = self.count;
            // 2.判断是否还有余票
            if (count > 0) {
                // 线程1 100
                [NSThread sleepForTimeInterval:0.1];
                // 2.1卖票
                self.count = count - 1; // 99
                NSLog(@"%@卖了一张票, 还剩%zd票", [NSThread currentThread].name, self.count);
            }else
            {
                // 3.提示客户, 没有票了
                NSLog(@"对不起, 没有票了");
                break;
            }
        } // 解锁
        
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
