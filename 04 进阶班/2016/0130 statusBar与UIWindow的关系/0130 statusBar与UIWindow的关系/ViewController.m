//
//  ViewController.m
//  0130 statusBar与UIWindow的关系
//
//  Created by 张思琦 on 16/1/30.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "TopWindowViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    // Do any additional setup after loading the view, typically from a nib.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeBarHidden:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) { // 显示
        [TopWindowViewController sharedTopWindowViewController].statusBarHidden = NO;
    } else { // 隐藏
        [TopWindowViewController sharedTopWindowViewController].statusBarHidden = YES;
    }
}

- (IBAction)chageBarStyle:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) { // 白色
        [TopWindowViewController sharedTopWindowViewController].statusBarStyle = UIStatusBarStyleLightContent;
    } else { // 黑色
        [TopWindowViewController sharedTopWindowViewController].statusBarStyle = UIStatusBarStyleDefault;
    }
}

@end
