//
//  SQLoginRegistViewController.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 15/11/8.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "SQLoginRegistViewController.h"

@interface SQLoginRegistViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIView *loginArea;

@property (weak, nonatomic) IBOutlet UIView *registerArea;

@property (weak, nonatomic) IBOutlet UIButton *chageButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftLeading;
@end

@implementation SQLoginRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = SQCommonBgColor;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 修改状态栏的颜色

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


#pragma mark - 返回按钮的功能实现
- (IBAction)closeClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        SQLOGFUNC;
    }];
}

#pragma mark - 注册按钮的功能实现
- (IBAction)registerClick:(UIButton *)button {
    SQLOGFUNC;
    [self.view endEditing:YES];

    if (self.leftLeading.constant == 0) {
        self.leftLeading.constant = - self.view.sq_width;
        button.titleLabel.text = @"已有帐号";
    }else{
        self.leftLeading.constant = 0;
        button.titleLabel.text = @"注册帐号";
    }

    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

#pragma mark - 自动推出编辑模式
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
