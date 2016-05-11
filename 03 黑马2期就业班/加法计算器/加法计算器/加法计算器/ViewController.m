//
//  ViewController.m
//  加法计算器
//
//  Created by 张思琦 on 15/7/11.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

//用于声明两个参数(人工输入)
@property (nonatomic, weak) IBOutlet UITextField *num1;
@property (nonatomic, weak) IBOutlet UITextField *num2;

//用于声明一个参数(结果输出)
@property (nonatomic, weak) IBOutlet UILabel *result;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//实现计算功能
- (IBAction)calculate
{
    NSString *n1 = self.num1.text;
    NSString *n2 = self.num2.text;
    
    self.result.text = [NSString stringWithFormat:@"%i", [n1 intValue] + [n2 intValue]];
}

@end
