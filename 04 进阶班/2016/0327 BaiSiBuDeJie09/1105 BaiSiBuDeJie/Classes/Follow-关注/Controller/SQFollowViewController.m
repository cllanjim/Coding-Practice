//
//  SQFollowViewController.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 15/11/7.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "SQFollowViewController.h"
#import "SQRecommandFollowViewController.h"
#import "SQLoginRegistViewController.h"
#import "UITextField+SQTextFieldExtension.h"

@interface SQFollowViewController ()

@property (nonatomic, strong) UITextField *textField;

@end

@implementation SQFollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = SQCommonBgColor;
    
    //设置NavigationBar中部的titleView
    self.navigationItem.title = @"我的关注";

    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem sq_itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(buttonClick)];

}

- (void)buttonClick{
    SQLOGFUNC;
    
    SQRecommandFollowViewController *vc = [[SQRecommandFollowViewController alloc] init];

    [self.navigationController pushViewController:vc animated:YES];
    
    
}

/**
 *  点击按钮后跳入登录界面
 *
 *  @param sender 登录按钮
 */

- (IBAction)loginRegister:(id)sender {
    SQLoginRegistViewController *vc = [[SQLoginRegistViewController alloc] init];
    //moda的方式弹出界面
    [self presentViewController:vc animated:YES completion:^{
        SQLOGFUNC;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
