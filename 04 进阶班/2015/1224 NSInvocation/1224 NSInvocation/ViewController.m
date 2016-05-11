//
//  ViewController.m
//  1224 NSInvocation
//
//  Created by 张思琦 on 15/12/24.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+performSelector.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
    //1创建签名
    //NSMethodSignature用于记录参数类型信息和返回值信息
    //哪个类需要注册签名就让哪个类调用该方法创建签名
    NSMethodSignature *signature = [[ViewController class] instanceMethodSignatureForSelector:@selector(sendMessageWithNumber:andContent:status:)];
    
    
    //在创建NSInvocation对象的同时要传递一个NSMethodSignature对象
    //NSInvocation对象是用来记录方法的一个对象
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    //设置执行方法的对象
    invocation.target = self;
    //设置执行的方法
    invocation.selector = @selector(sendMessageWithNumber:andContent:status:);
    //设置方法的参数
    NSString *argument01 = @"10086";
    NSString *argument02 = @"Hello World";
    NSString *argumeng03 = @"Fine";
    //invocation将第0号和第1号位置预留给了self和_cmd两个参数,所以设置参数要从2号开始
    [invocation setArgument:&argument01 atIndex:2];
    [invocation setArgument:&argument02 atIndex:3];
    [invocation setArgument:&argumeng03 atIndex:4];
    //执行方法
    [invocation invoke];
    */
    
    
    [self performSelector:@selector(sendMessageWithNumber:andContent:) withObjects:@[@"1",@"2",@"3"]];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Method To Use
- (NSString *)test
{
    return @"lnj";
}

- (void)call
{
    NSLog(@"%s", __func__);
}

// callWithNumber:
- (void)callWithNumber:(NSString *)number
{
    NSLog(@"打电话给%@", number);
}

//sendMessageWithNumber:andContent:
- (void)sendMessageWithNumber:(NSString *)number andContent:(NSString *)content
{
    number.length;
    NSLog(@"发信息给%@, 内容是%@", number, content);
}

- (void)sendMessageWithNumber:(NSString *)number andContent:(NSString *)content status:(NSString *)status
{
    NSLog(@"发信息给%@, 内容是%@, 发送的状态是%@", number, content, status);
}

@end
