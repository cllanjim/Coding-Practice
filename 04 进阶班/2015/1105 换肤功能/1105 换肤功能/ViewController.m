//
//  ViewController.m
//  1105 换肤功能
//
//  Created by 张思琦 on 15/11/5.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISwitch *s = [[UISwitch alloc] init];
    s.center = CGPointMake(100, 100);
    s.on = YES;
    [self.view addSubview:s];
    //    self.s = s;
    
    UISwitch *s1 = [[UISwitch alloc] init];
    s1.center = CGPointMake(200, 100);
    s1.on = YES;
    [self.view addSubview:s1];
    
    UISwitch *s2 = [[UISwitch alloc] init];
    s2.center = CGPointMake(300, 100);
    s2.on = YES;
    [self.view addSubview:s2];
    
    UISwitch *s3 = [[UISwitch alloc] init];
    s3.center = CGPointMake(100, 200);
    s3.on = YES;
    [self.view addSubview:s3];
    
    UISwitch *s4 = [[UISwitch alloc] init];
    s4.center = CGPointMake(200, 200);
    s4.on = YES;
    [self.view addSubview:s4];
    
    UISwitch *s5 = [[UISwitch alloc] init];
    s5.center = CGPointMake(300, 200);
    s5.on = YES;
    [self.view addSubview:s5];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)changeColor:(UISegmentedControl *)sender {
    
    switch (sender.selectedSegmentIndex) {
        case 0: // 蓝色
            [UISwitch appearance].onTintColor = [UIColor blueColor];
            break;
            
        case 1: // 红色
            [UISwitch appearance].onTintColor = [UIColor redColor];
            break;
            
        case 2: // 橙色
            [UISwitch appearance].onTintColor = [UIColor orangeColor];
            break;
    }
    
    [self.view removeFromSuperview];
    [[UIApplication sharedApplication].keyWindow addSubview:self.view];
    
//    // 重新添加控件
//    [self.view removeFromSuperview];
//    [[UIApplication sharedApplication].keyWindow addSubview:self.view];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
