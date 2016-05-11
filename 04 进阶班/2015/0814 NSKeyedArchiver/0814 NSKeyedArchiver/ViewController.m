//
//  ViewController.m
//  0814 NSKeyedArchiver
//
//  Created by 张思琦 on 15/8/16.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建一个自定义类对象
    Person *person = [[Person alloc] init];
    person.name = @"ZSQ";
    person.age = @"19";
    
    
    //获取当前应用沙盒的根目录
    NSString *tmp = NSTemporaryDirectory();
    //保存地址
    NSString *filePath = [tmp stringByAppendingString:@"person.data"];
    
    //归档
    [NSKeyedArchiver archiveRootObject:person toFile:filePath];
    
    //解档
    Person *copyPerson = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    NSLog(@"%@", copyPerson);
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
