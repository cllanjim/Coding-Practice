//
//  TextViewController.m
//  0124 图片折叠
//
//  Created by 张思琦 on 16/1/25.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "TextViewController.h"

@interface TextViewController ()

@end

@implementation TextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加conentView
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    contentView.center = self.view.center;
    contentView.backgroundColor = [UIColor redColor];
    [self.view addSubview:contentView];
    
    //添加下半部分的头像
    UIImageView *underView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 200, 100)];
    underView.image = [UIImage imageNamed:@"portrait"];
    underView.layer.contentsRect = CGRectMake(0, 0.5, 1, 0.5);
    underView.layer.anchorPoint = CGPointMake(0.5, 0);
    underView.layer.position = CGPointMake(100, 100);
    [contentView addSubview:underView];
    
    //添加上半部分的头像
    UIImageView *upperView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];;
    upperView.image = [UIImage imageNamed:@"portrait"];
    upperView.layer.contentsRect = CGRectMake(0, 0, 1, 0.5);
    upperView.layer.anchorPoint = CGPointMake(0.5, 1);
    upperView.layer.position = CGPointMake(100, 100);
    [contentView addSubview:upperView];
    
    
    
    
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
