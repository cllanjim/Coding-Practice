//
//  ViewController.m
//  1004 PickerView综合应用
//
//  Created by 张思琦 on 15/10/4.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "NationTextField.h"
#import "UITextField+LoginText.h"

@interface ViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *brithLabel;
@property (weak, nonatomic) IBOutlet NationTextField *nationLabel;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameLabel.delegate = self;
    self.brithLabel.delegate = self;
    self.nationLabel.delegate = self;
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - <UITextFieldDelegate>

////是否允许开始编辑
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    return NO;
//}


////是否允许结束编辑
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
//    return NO;
//    
//}

//是否允许改变指定区域的文字
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [textField prepareForUse];
}

@end
