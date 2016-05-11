//
//  ViewController.m
//  0928 键盘处理
//
//  Created by 张思琦 on 15/9/28.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textFiled;
//底部约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomHeight;
@end

@implementation ViewController



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//在点击键盘框以外的区域,使得键盘自动退出
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //方法1
    //当前控件取消自身第一响应者的状态
    //[self.textFiled resignFirstResponder];
    
    //方法2
    //当前控件退出编辑模式
    //[self.textFiled endEditing:YES];
    
    //方法3
    //该控件内的所有子控件都会退出编辑模式
    [self.view endEditing:YES];

}

#pragma mark - 键盘处理
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //方法一
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    //方法二
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)keyBoardWillShow:(NSNotification *)note{

    CGRect frame = [note.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    self.bottomHeight.constant = frame.size.height;
    
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
    
    NSLog(@"%@",note.userInfo);
}

- (void)keyBoardWillHide:(NSNotification *)note{
    
    self.bottomHeight.constant = 0;
    
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
    
    NSLog(@"%@",note.userInfo);

}

- (void)keyBoardWillChange:(NSNotification *)note{

    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //特别注意此处的计算公式
    self.bottomHeight.constant = self.view.frame.size.height - frame.origin.y;
    
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}


@end
