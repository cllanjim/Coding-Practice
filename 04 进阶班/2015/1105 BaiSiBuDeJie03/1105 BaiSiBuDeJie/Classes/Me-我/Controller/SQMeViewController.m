//
//  SQMeViewController.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 15/11/7.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "SQMeViewController.h"
#import "SQSettingViewController.h"


@interface SQMeViewController ()

@end

@implementation SQMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = SQCommonBgColor;
    // 标题
    self.navigationItem.title = @"我的";
//    // 右边-设置
//    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [settingButton setImage:[UIImage imageNamed:@"mine-setting-icon"] forState:UIControlStateNormal];
//    [settingButton setImage:[UIImage imageNamed:@"mine-setting-icon-click"] forState:UIControlStateHighlighted];
//    [settingButton addTarget:self action:@selector(settingClick) forControlEvents:UIControlEventTouchUpInside];
//    [settingButton sizeToFit];
//    UIBarButtonItem *settingItem = [[UIBarButtonItem alloc] initWithCustomView:settingButton];
    
    // 右边-月亮
    //    UIButton *moonButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [moonButton setImage:[UIImage imageNamed:@"mine-moon-icon"] forState:UIControlStateNormal];
    //    [moonButton setImage:[UIImage imageNamed:@"mine-moon-icon-click"] forState:UIControlStateHighlighted];
    //    [moonButton addTarget:self action:@selector(moonClick) forControlEvents:UIControlEventTouchUpInside];
    //    [moonButton sizeToFit];
    //    UIBarButtonItem *moonItem = [[UIBarButtonItem alloc] initWithCustomView:moonButton];
    
    
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];
}

- (void)settingClick
{
    SQLOGFUNC;
    SQSettingViewController *vc = [[SQSettingViewController alloc] init];
//    vc.view.backgroundColor = SQRandomColor;
//    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)moonClick
{
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
