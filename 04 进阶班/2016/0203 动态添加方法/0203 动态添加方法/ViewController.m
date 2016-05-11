//
//  ViewController.m
//  0203 动态添加方法
//
//  Created by 张思琦 on 16/2/3.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    Person *zsq = [[Person alloc] init];
    //动态调用eat方法
    [zsq performSelector:@selector(eat)];
    [zsq eat];
    
//    [[Person class] performSelector:@selector(eat)];
//    [Person eat];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
