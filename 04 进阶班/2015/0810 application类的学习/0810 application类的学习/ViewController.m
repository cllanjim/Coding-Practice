//
//  ViewController.m
//  0810 application类的学习
//
//  Created by 张思琦 on 15/8/12.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "SQxixi.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //实际操作步骤如下
    UIApplication *myApp = [UIApplication sharedApplication];
   
    //@property(nonatomic) NSInteger applicationIconBadgeNumber;
    //在ios8.0以后使用applicationIconBadgeNumber属性,需要先调用-[UIApplication registerUserNotificationSettings:]方法
    //设定气泡数
    myApp.applicationIconBadgeNumber = 10;
    //创建NotificationSetting对象
    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    //将该通知注册到application中
    [myApp registerUserNotificationSettings:setting];
    

    //@property(nonatomic,getter=isNetworkActivityIndicatorVisible) BOOL networkActivityIndicatorVisible;
    //设置联网状态
    
    myApp.networkActivityIndicatorVisible = YES;
    
    
    
    //不能创建xixi类的对象
    //SQxixi *xixi2 = [[SQxixi alloc] init];
    //通过提供的方法获取该对象
//    SQxixi *xixi = [SQxixi sharedxixi];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
