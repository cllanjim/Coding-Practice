//
//  SQxixi.m
//  0810 application类的学习
//
//  Created by 张思琦 on 15/8/12.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "SQxixi.h"

@implementation SQxixi

static SQxixi *_xixi;

//重写load方法
+ (void)load
{
    //官方文档建议在调研load方法前,让其父类先进行load
    [super load];
    
    _xixi = [[self alloc] init];
    
}


//重写alloc方法
+(instancetype)alloc
{
    //判断_box是否为空
    //如果非空,就让程序崩溃
    if (_xixi != nil) {
        //创建一个异常报警
        //name:         The name of the exception.
        //reason:       A human-readable message string summarizing the reason for the exception.
        //userInfo:     A dictionary containing user-defined information relating to the exception
        NSException *exception = [NSException exceptionWithName:@"不能克隆她!" reason:@"xixi是独一无二的!" userInfo:nil];
        
        
        //raise方法是指抛出调用raise方法的异常
        [exception raise];
    }
    
    //如果是空,就返回一块内存地址,让其进行实例化
    return [super alloc];
    
}

+ (instancetype)sharedxixi
{
    return _xixi;
}
@end
