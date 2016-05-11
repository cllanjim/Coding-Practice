//
//  ViewController.m
//  0928 键盘处理-多文本框
//
//  Created by 张思琦 on 15/9/28.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *ageTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *emailTextFiled;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameTextFiled.delegate = self;
    self.ageTextFiled.delegate = self;
    self.emailTextFiled.delegate = self;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//当设置return Key时会调用这个方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    if (textField == self.nameTextFiled) {
        // 让phoneField成为第一响应者（phoneField会出聚焦）
        [self.ageTextFiled becomeFirstResponder];
    } else if (textField == self.ageTextFiled) {
        [self.emailTextFiled becomeFirstResponder];
    } else if (textField == self.emailTextFiled) {
        [self.view endEditing:YES];
    }
    return YES;
}


@end
