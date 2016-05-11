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

@property (nonatomic, strong) RedViewController *redVC;
@property (nonatomic, strong) YellowViewController *yelVC;
@property (nonatomic, strong) GreenViewController *greVC;


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
    //对viewController的创建进行判断,如果为nil,就创建新的对象并赋值
    if (self.greVC == nil) {
        GreenViewController *greVC = [[GreenViewController alloc] init];
        self.greVC = greVC;
    }
    //把greVC的view添加到当前viewController的view中
    [self.view addSubview:self.greVC.view];
    //移除其他view
    [self.redVC.view removeFromSuperview];
    [self.yelVC.view removeFromSuperview];
    
    
    
//    GreenViewController *greVC = [[GreenViewController alloc] init];
//    greVC.view.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height);
//    greVC.view.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:greVC.view];
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
