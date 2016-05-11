//
//  ViewController.m
//  0814 UesrDefaults
//
//  Created by 张思琦 on 15/8/16.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSUserDefaults standardUserDefaults] setObject:@"ZSQ" forKey:@"name"];
    
    NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
