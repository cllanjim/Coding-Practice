//
//  ViewController.m
//  0929 UIAlertView
//
//  Created by 张思琦 on 15/9/29.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIAlertViewDelegate>

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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"这只是一个测试" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",@"再来一个", nil];
    
//    UIAlertViewStyleDefault = 0,
//    UIAlertViewStyleSecureTextInput,
//    UIAlertViewStylePlainTextInput,
//    UIAlertViewStyleLoginAndPasswordInput
    alertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%ld-----%@", buttonIndex, [alertView textFieldAtIndex:0].text);
}


@end
