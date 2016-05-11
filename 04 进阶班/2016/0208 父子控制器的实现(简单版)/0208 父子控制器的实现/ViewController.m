//
//  ViewController.m
//  0208 父子控制器的实现
//
//  Created by 张思琦 on 16/2/8.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "RedViewController.h"
#import "YellowViewController.h"
#import "GreenViewController.h"

@interface ViewController ()




@end

@implementation ViewController
- (IBAction)redButton:(id)sender {

    RedViewController *redVC = [[RedViewController alloc] init];
    redVC.view.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height);
    redVC.view.backgroundColor = [UIColor redColor];
    [self.view addSubview:redVC.view];
    
}


- (IBAction)yellowButton:(id)sender {
    YellowViewController *yelVC = [[YellowViewController alloc] init];
    yelVC.view.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height);
    yelVC.view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:yelVC.view];
    
}


- (IBAction)greenButton:(id)sender {
    GreenViewController *greVC = [[GreenViewController alloc] init];
    greVC.view.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height);
    greVC.view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:greVC.view];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
