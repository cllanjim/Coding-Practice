//
//  ViewController.m
//  0822 LoadView
//
//  Created by 张思琦 on 15/8/22.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)loadView{

    //标准流程
//    UIView *myView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //注意点
    //1. 设置frame时,不能调用self.view
//    UIView *myView = [[UIView alloc] initWithFrame:self.view.bounds];
    //2. frame会强制生成, 虽然frame为0,但仍然填充屏幕
    UIView *myView = [[UIView alloc] initWithFrame:CGRectZero];
    myView.backgroundColor = [UIColor lightGrayColor];
    self.view = myView;
    //[super loadView];
}

//- (UIView *)view
//{
//    if (_view == nil) {
//        [self loadView];
//    }
//    return _view;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
