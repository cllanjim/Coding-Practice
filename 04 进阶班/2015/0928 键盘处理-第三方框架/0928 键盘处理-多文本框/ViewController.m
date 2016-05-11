//
//  ViewController.m
//  0928 键盘处理-多文本框
//
//  Created by 张思琦 on 15/9/28.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "KeyboardManager.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *ageTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *emailTextFiled;

@property (nonatomic, strong) IQKeyboardReturnKeyHandler *handler;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建管理者
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];

    //点击键盘区域以外的地方,能够自动退出键盘
    manager.shouldResignOnTouchOutside = YES;
    
    //textField的切换跟控件在图层中的顺序有关
    
    //关闭toolBar
//    manager.enableAutoToolbar = NO;
    
    //toolBar是否可以使用tintColor
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    
    //创建管理return key的handler对象
    IQKeyboardReturnKeyHandler *handler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
    self.handler = handler;
    
    //将最后一个textFiled的return键设置为done
    self.handler.lastTextFieldReturnKeyType = UIReturnKeyDone;
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
