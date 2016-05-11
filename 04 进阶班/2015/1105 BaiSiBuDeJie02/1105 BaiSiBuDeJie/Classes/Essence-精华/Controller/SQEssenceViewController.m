//
//  SQEssenceViewController.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 15/11/7.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "SQEssenceViewController.h"

@interface SQEssenceViewController ()

@end

@implementation SQEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = SQCommonBgColor;
    
    //设置NavigationBar中部的titleView
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
//    //设置NavigationBar左部的按钮
//    //创建Button
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    //设置Button的样式及大小
//    [button setImage:[UIImage imageNamed:@"MainTagSubIcon"] forState:UIControlStateNormal];
//    [button setImage:[UIImage imageNamed:@"MainTagSubIconClick"] forState:UIControlStateSelected];
//    [button sizeToFit];
//    //监听Button的点击事件
//    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
//    
//    //将button添加到NavigationBar中
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(buttonClick)];

}

- (void)buttonClick{
    SQLOGFUNC;
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
