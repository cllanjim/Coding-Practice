//
//  ViewController.m
//  0924 数据传递-NSNotificationCenter
//
//  Created by 张思琦 on 15/9/24.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "SQPerson.h"
#import "SQCompany.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SQPerson *person0 = [[SQPerson alloc] init];
    person0.name = @"ZSQ";
    
    SQPerson *person1 = [[SQPerson alloc] init];
    person1.name = @"SQ";
    
    SQCompany *company0 = [[SQCompany alloc] init];
    company0.name = @"腾讯";
    
    SQCompany *company1 = [[SQCompany alloc] init];
    company1.name = @"新浪";
    
    //在NSNotificationCenter中注册监听者
    [[NSNotificationCenter defaultCenter] addObserver:person0 selector:@selector(receiveNews:) name:@"足球" object:company0];
     [[NSNotificationCenter defaultCenter] addObserver:person1 selector:@selector(receiveNews:) name:@"娱乐" object:company1];
    
    //创建通知
   NSNotification *note = [[NSNotification alloc] initWithName:@"足球" object:company0 userInfo:@{
                                                                         @"曼联":@"获胜",
                                                                         @"巴萨":@"失败"
                                                                         }];
    
    //发布通知
    [[NSNotificationCenter defaultCenter] postNotification:note];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"娱乐" object:company1 userInfo:@{
                                                                        @"陈冠希":@"获胜",
                                                                        @"张柏芝":@"失败"
                                                                        }];

    
    
    //移除监听者
    [[NSNotificationCenter defaultCenter] removeObserver:person0];
    [[NSNotificationCenter defaultCenter] removeObserver:person1];

    
    //整个过程等于发布通知,即把通知中的信息传递给监听者
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
