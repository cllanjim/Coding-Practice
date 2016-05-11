//
//  SQNavigationController.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 15/11/7.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "SQNavigationController.h"

@interface SQNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation SQNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = self;

    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //在该方法中应当坚持先设定好控制器的所有内容再将其push到NavigationController中
    
    //当子控制器的数量等于0,就说明是第一次推送进来,以后子控制器的数量将至少大于1,根控制器无法被删除
    //不能选择大于1是因为在第一次推送的时候,由于子控制的数量不大于1,会无法将底部的TabBar隐藏
    //  解决办法:将TabBar的隐藏工作交到对应的控制器处理
    if (self.childViewControllers.count > 0) {
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateSelected];
        [backButton sizeToFit];
        //调整左边返回按钮的位置
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        
        [backButton addTarget:self action:@selector(backClikck) forControlEvents:UIControlEventTouchUpInside];
        
        //在将要push的ViewController上进行操作
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        //将隐藏功能封装到NavigationController的push方法中
        viewController.hidesBottomBarWhenPushed = YES;
    }

    [super pushViewController:viewController animated:animated];
}

- (void)backClikck{
    
    [self popViewControllerAnimated:YES];
}

//从边缘
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    //当子控制数量等于1或0说明是在当前navigationController的根控制器或者还没推送
    return self.childViewControllers.count > 1;
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
