//
//  ViewController.m
//  0903 单例 - MRC
//
//  Created by 张思琦 on 15/9/3.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "Tool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Tool *t1 = [[Tool alloc] init];
    Tool *t2 = [Tool new];
    Tool *t3 = [Tool shareTool];
    NSLog(@"%p----%p----%p",t1, t2, t3);
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
