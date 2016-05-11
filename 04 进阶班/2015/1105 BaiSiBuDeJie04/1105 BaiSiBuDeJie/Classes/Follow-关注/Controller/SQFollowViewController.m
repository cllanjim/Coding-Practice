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
//    //设置NavigationBar左部的按钮
//    //创建Button
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    //设置Button的样式及大小
//    [button setImage:[UIImage imageNamed:@"friendsRecommentIcon"] forState:UIControlStateNormal];
//    [button setImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] forState:UIControlStateSelected];
//    [button sizeToFit];
//    //监听Button的点击事件
//    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];    
//    //将button添加到NavigationBar中
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(buttonClick)];

//    //实现多行文字
//    //创建富文本对象
//    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
//    attr[NSBackgroundColorAttributeName] = [UIColor greenColor];
//    attr[NSFontAttributeName]= [UIFont systemFontOfSize:13];
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"123\n456" attributes:attr];
//    //设置UILabel对象并赋值给titleView
//    UILabel *laber = [[UILabel alloc] init];
//    laber.numberOfLines = 0;
//    laber.frame = CGRectMake(0, 0, 100, 40);
//    laber.attributedText = attributedString;
//    self.navigationItem.titleView = laber;

 
//    //实现图文混排
//    //第一段文字
//    NSMutableDictionary *attr1 = [NSMutableDictionary dictionary];
//    attr1[NSBackgroundColorAttributeName] = [UIColor greenColor];
//    attr1[NSFontAttributeName]= [UIFont systemFontOfSize:13];
//    NSAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:@"123" attributes:attr1];
//    
//    //中间图片
//    NSTextAttachment *imageText = [[NSTextAttachment alloc] init];
//    imageText.image = [UIImage imageNamed:@"header_cry_icon"];
//    NSAttributedString *attributedString2 = [NSMutableAttributedString attributedStringWithAttachment:imageText];
//    
//    //第二段文字
//    NSMutableDictionary *attr2 = [NSMutableDictionary dictionary];
//    attr2[NSBackgroundColorAttributeName] = [UIColor greenColor];
//    attr2[NSFontAttributeName]= [UIFont systemFontOfSize:13];
//    NSAttributedString *attributedString3 = [[NSMutableAttributedString alloc] initWithString:@"\n456" attributes:attr2];
//    
//    //合并图片与文字
//    NSMutableAttributedString *combine = [[NSMutableAttributedString alloc] init];
//    [combine appendAttributedString:attributedString1];
//    [combine appendAttributedString:attributedString2];
//    [combine appendAttributedString:attributedString3];
//    
//    //设置UILable
//    UILabel *laber = [[UILabel alloc] init];
//    laber.numberOfLines = 0;
//    laber.frame = CGRectMake(0, 0, 100, 40);
//    laber.attributedText = combine;
//    self.navigationItem.titleView = laber;
    
    
    UITextField *textField = [[UITextField alloc] init];
    textField.backgroundColor = [UIColor yellowColor];
    textField.frame = CGRectMake(100, 100, 200, 50);
//    textField.placeholderColor = [UIColor orangeColor];
    textField.placeholder = @"123";
//    textField.placeholderColor = nil;
    self.textField = textField;
    
    NSLog(@"%@",self.textField.placeholderColor);
//    NSLog(@"%@",self.textField.placeholder);
    [self.view addSubview:self.textField];
    
    
}

- (void)buttonClick{
    SQLOGFUNC;
    
    SQRecommandFollowViewController *vc = [[SQRecommandFollowViewController alloc] init];
//    vc.view.backgroundColor= SQCommonBgColor;
    //使用系统的NavigationBar时有效
//    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
    // Do any additional setup after loading the view.

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
