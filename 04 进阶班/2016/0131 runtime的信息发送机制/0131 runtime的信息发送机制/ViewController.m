//
//  ViewController.m
//  0131 runtime的信息发送机制
//
//  Created by 张思琦 on 16/1/31.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
//导入消息机制框架
#import <objc/message.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //对象方法
    Person *zsq = [[Person alloc] init];
    //对象调用对象方法的形式1
    [zsq run];
    //对象调用对象方法的形式2
    [zsq performSelector:@selector(run)];
    //对象调用对象方法的形式3
    //objc_msgSend(id self, SEL op, ...)
    //self参数指发送消息的对象
    //op参数指需要执行的方法
    //...代表方法的参数
    objc_msgSend(zsq, @selector(run));
    
    //类方法
    Class chinese = [Person class];
    //类对象调用类方法的形式1
    [Person run];
    //类对象调用类方法的形式2
    [[Person class] run];
    //类对象调用类方法的形式3
    [Person performSelector:@selector(run)];
    //类对象调用类方法的形式4
    [[Person class] performSelector:@selector(run)];
    //类对象调用类方法的形式5
    objc_msgSend(chinese, @selector(run));
    objc_msgSend([Person class], @selector(run));

    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
