//
//  ViewController.m
//  0814 navigationBar的相关属性
//
//  Created by 张思琦 on 15/8/15.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //title属性
    self.navigationItem.title = @"第一页";
    //titleView属性
    self.navigationItem.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 10)];
    self.navigationItem.titleView.backgroundColor = [UIColor redColor];
    
    //根据title创建
    UIBarButtonItem *button =[[UIBarButtonItem alloc] initWithTitle:@"xixi" style:UIBarButtonItemStylePlain target:self action:nil];
    //根据图像创建
    UIBarButtonItem *button1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] style:UIBarButtonItemStylePlain target:self action:nil];
    //但是图像会被渲染成蓝色
    UIImage *image = [UIImage imageNamed:@"navigationbar_friendsearch_highlighted"];
    //下面的方法会保证图像加入UIbarButtonItem时不被渲染
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *button2 = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:nil];
    
    //在右侧放一个按钮
    self.navigationItem.rightBarButtonItem = button;
    //在右侧放一组按钮
    self.navigationItem.rightBarButtonItems = @[button,button1,button2];
    
    
    // Do any additional setup after loading the view from its nib.
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
