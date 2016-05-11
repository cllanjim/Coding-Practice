//
//  thridViewController.m
//  0814 UINavigationController的基本使用
//
//  Created by 张思琦 on 15/8/14.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "thridViewController.h"

@interface thridViewController ()

@end

@implementation thridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)prevPage:(id)sender {

    //返回栈中前一个viewController
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)bootPage:(id)sender {
    
    //返回栈中制定的viewController
    [self.navigationController popToViewController:self.navigationController.childViewControllers[0] animated:YES];
    
    //返回栈中的跟viewController
    //[self.navigationController popToRootViewControllerAnimated:YES];
    
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
