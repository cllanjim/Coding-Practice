//
//  ViewController.m
//  0929 自定义HUD
//
//  Created by 张思琦 on 15/9/29.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

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
    
    //创建HUD框
    UIView *cover = [[UIView alloc] init];
    cover.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    cover.center = self.view.center;
    cover.bounds = CGRectMake(0, 0, 200, 200);
    cover.layer.cornerRadius = 10;
    [self.view addSubview:cover];
    
    //创建菊花
    //UIActivityIndicatorViewStyleWhiteLarge,
    //UIActivityIndicatorViewStyleWhite,
    //UIActivityIndicatorViewStyleGray,
    UIActivityIndicatorView *indicatiorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicatiorView startAnimating];
    //出现错误的原因是center以父控件为准
//    indicatiorView.center = cover.center;
    indicatiorView.center = CGPointMake(cover.frame.size.width * 0.5, cover.frame.size.height * 0.5);
    [cover addSubview:indicatiorView];
    
    //创建文本框
    // 往遮盖中添加提醒文字
    UILabel *label = [[UILabel alloc] init];
    label.text = @"正在拼命加载中...";
    //文字对齐方式
    label.textAlignment = NSTextAlignmentCenter;
    CGFloat labelH = 70;
    label.textColor = [UIColor whiteColor];
    label.frame = CGRectMake(0, cover.frame.size.height - labelH, cover.frame.size.width, labelH);
    [cover addSubview:label];


}



@end
