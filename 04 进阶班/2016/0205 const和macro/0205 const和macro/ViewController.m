//
//  ViewController.m
//  0205 const和macro
//
//  Created by 张思琦 on 16/2/5.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    int a = 10;
    int b = 30;
    
//    int * const p = &a;
    
//    int const *  p = &a;
    
    int  *p = &a;

    p = &b;
    *p = 40;
    
    //输出地址
    NSLog(@"%p", p);
    NSLog(@"%p", &a);

    //输出信息
    NSLog(@"%d",*p);
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
