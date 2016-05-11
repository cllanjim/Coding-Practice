//
//  ViewController.m
//  0814 数据存储 - plist
//
//  Created by 张思琦 on 15/8/16.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //应用沙盒的路径获取方式
    NSString *home = NSHomeDirectory();
    NSLog(@"%@", home);
    
    //document路径的获取方式
    //1 拼接字符串
    NSString *document00 = [home stringByAppendingString:@"/Documents"];
    NSLog(@"%@", document00);

    //2 使用函数
    NSString *document01 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSLog(@"%@", document01);

    
    //tmp目录的获取方式
    NSString *tmp = NSTemporaryDirectory();
    NSLog(@"%@", tmp);

    //Library/caches目录的获取方式
    //1拼接字符串
    NSString *caches00 = [home stringByAppendingString:@"/Library/Caches"];
    NSLog(@"%@", caches00);
    //2使用函数
    NSString *caches01 = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSLog(@"%@", caches01);
    
    //存放文件的路径要加上文件名
    NSString *filePath = [tmp stringByAppendingString:@"name.plist"];
    //写入的内容
    NSString *name = @"ZSQ";
    //写入进文件的方法
    [name writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    

    //读取文件时,需要注意一个原则
    //存的时候用什么对象存,读取的时候也是用什么对象读取
    NSString *string  = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@",string);

    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
