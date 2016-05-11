//
//  TopWindowViewController.m
//  0130 statusBar与UIWindow的关系
//
//  Created by 张思琦 on 16/1/30.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "TopWindowViewController.h"

@interface TopWindowViewController ()

@end

@implementation TopWindowViewController

#pragma mark - 创建方法
+ (instancetype)sharedTopWindowViewController{

    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{

    static TopWindowViewController *singletonInstance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singletonInstance = [super allocWithZone:zone];
    });
    return singletonInstance;
}

#pragma mark - setter
- (void)setStatusBarHidden:(BOOL)statusBarHidden
{
    _statusBarHidden = statusBarHidden;
    //setNeedsStatusBarAppearanceUpdate方法用于更新statusBar的状态
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle
{
    _statusBarStyle = statusBarStyle;
    //setNeedsStatusBarAppearanceUpdate方法用于更新statusBar的状态
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - statusBar
- (UIStatusBarStyle)preferredStatusBarStyle{
    return self.statusBarStyle;
}

- (BOOL)prefersStatusBarHidden{
    return self.statusBarHidden;
}

#pragma mark - 生命周期的方法
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
