//
//  secondViewController.m
//  0814 UINavigationController的基本使用
//
//  Created by 张思琦 on 15/8/14.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "firstViewController.h"
#import "secondViewController.h"
#import "thridViewController.h"

@interface secondViewController ()

@end

@implementation secondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)nextPage:(id)sender {
    thridViewController *thridView = [[thridViewController alloc] initWithNibName:@"thridViewController" bundle:nil];
    
    [self.navigationController pushViewController:thridView animated:YES];
    
}
- (IBAction)prevPage:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
