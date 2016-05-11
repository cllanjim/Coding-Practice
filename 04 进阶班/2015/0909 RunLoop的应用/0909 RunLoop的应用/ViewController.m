//
//  ViewController.m
//  0909 RunLoop的应用
//
//  Created by 张思琦 on 15/9/9.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "SQThread.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong)  SQThread *thread ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建线程
    SQThread *thread = [[SQThread alloc] initWithTarget:self selector:@selector(demo) object:nil];
    self.thread = thread;
    [self.thread start];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)demo {
    // 在子线程执行
    NSLog(@"%s", __func__);
    
    [self performSelector:@selector(test) onThread:self.thread withObject:nil waitUntilDone:NO];
    NSLog(@"1");

}

- (void)test
{
    NSLog(@"%s %@", __func__, [NSThread currentThread]);
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self performSelector:@selector(changeImage) withObject:nil afterDelay:2.0];
    [self performSelector:@selector(changeImage) withObject:nil afterDelay:2.0 inModes:@[NSDefaultRunLoopMode]];
    
    
    [self.imageView performSelector:@selector(setImage:) withObject:[UIImage imageNamed:@"def"] afterDelay:2.0];
    [self.imageView performSelector:@selector(setImage:) withObject:[UIImage imageNamed:@"def"] afterDelay:2.0 inModes:@[NSDefaultRunLoopMode]];
}

- (void)changeImage{
    self.imageView.image = [UIImage imageNamed:@"def"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
