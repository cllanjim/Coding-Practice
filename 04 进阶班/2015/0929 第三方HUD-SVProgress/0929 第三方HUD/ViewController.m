//
//  ViewController.m
//  0929 第三方HUD
//
//  Created by 张思琦 on 15/9/29.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "SVProgressHUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [SVProgressHUD show];

    self.view.backgroundColor = [UIColor redColor];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    //需要主动调用dismiss方法隐藏
    [SVProgressHUD show];
    [SVProgressHUD showWithStatus:@"开什么玩笑..."];
    //被弃用
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    //以下方法会自动隐藏
    [SVProgressHUD showInfoWithStatus:@"然并卵"];
    [SVProgressHUD showSuccessWithStatus:@"Holy Shit"];
    [SVProgressHUD showErrorWithStatus:@"神马鬼"];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(progressSV) userInfo:nil repeats:YES];
}

static double progress = 0.0;
- (void)progressSV{

    progress += 0.1;
    [SVProgressHUD showProgress:progress status:[NSString stringWithFormat:@"以下载%.01f %%",progress*100]];
    
}


@end
