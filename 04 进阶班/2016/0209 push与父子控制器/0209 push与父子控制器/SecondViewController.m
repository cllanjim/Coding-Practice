//
//  SecondViewController.m
//  0209 push与父子控制器
//
//  Created by 张思琦 on 16/2/9.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    self.view.frame = CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height);
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //    NSLog(@"%s",__func__);
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor greenColor];
    // self.navigationController:只要是导航控制器的子控制器就可以拿到
    NSLog(@"%s",__func__);

    NSLog(@"%@",self.navigationController);
    
    NSLog(@"%@",self.navigationController.childViewControllers);
    
    // self.navigationController:首先去寻找自己是不是导航控制器子控制器
    // 就会去看自己的父控制是不是导航控制器子控制器
    
    [self.navigationController pushViewController:vc animated:YES];
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
