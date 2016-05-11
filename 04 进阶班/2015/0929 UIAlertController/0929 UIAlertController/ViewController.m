//
//  ViewController.m
//  0929 UIAlertController
//
//  Created by 张思琦 on 15/9/29.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

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

    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"警告" message:@"这是一个测试" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"UIAlertActionStyleDefault" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"确定你妹啊!");
    }];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"UIAlertActionStyleCancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"确定你妹啊!");
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"UIAlertActionStyleDestructive" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"确定你妹啊!");
    }];
    
    [alertView addAction:action0];
    [alertView addAction:action1];
    [alertView addAction:action2];
    
    
    [alertView addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.textColor = [UIColor orangeColor];
        textField.secureTextEntry = YES;
        textField.placeholder = @"你猜猜?";
    }];
    [alertView addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.textColor = [UIColor orangeColor];
        textField.placeholder = @"你猜猜?";
    }];
    
    [self presentViewController:alertView animated:YES completion:nil];
    
    
    
}


//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    
//    //preferredStyle 分为2类
//    //    UIAlertControllerStyleActionSheet = 0,
//    //    UIAlertControllerStyleAlert
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"这是一个测试" preferredStyle:UIAlertControllerStyleActionSheet];
//
//    //style 分为3类
//    //    UIAlertActionStyleDefault = 0,
//    //    UIAlertActionStyleCancel,
//    //    UIAlertActionStyleDestructive
//    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"UIAlertActionStyleDefault" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        NSLog(@"确定你妹啊!");
//    }];
//    [alertController addAction:action0];
//    
//    //只能有一个UIAlertActionStyleCancel
//    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"UIAlertActionStyleCancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        NSLog(@"确定你妹啊!");
//    }];
//    [alertController addAction:action1];
//    
//    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"UIAlertActionStyleDestructive" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//        NSLog(@"确定你妹啊!");
//    }];
//    [alertController addAction:action2];
//    
//    //在当前viewController中添加alertController 类似moda的方法
//    [self presentViewController:alertController animated:YES completion:nil];
//    
//    
//}

@end
