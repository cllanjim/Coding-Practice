//
//  ViewController.m
//  0121 转盘
//
//  Created by 张思琦 on 16/1/21.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "WheelView.h"

@interface ViewController ()

@property (nonatomic, strong) WheelView *wheelView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WheelView *wheelView = [WheelView wheel];
    //从xib加载的文件带有默认的frame值
    wheelView.center = self.view.center;
    
//    CGRect frame = CGRectMake(30, 30, 100, 200);
//    wheelView.frame = frame;
//    wheelView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:wheelView];
    
    NSLog(@"%@",NSStringFromCGRect(wheelView.frame));
    
    self.wheelView = wheelView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button功能

- (IBAction)startRotation:(UIButton *)sender {
    [self.wheelView startRotate];
}

- (IBAction)pauseRotation:(UIButton *)sender {
    [self.wheelView pauseRotate];
}



@end
