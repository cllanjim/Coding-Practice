//
//  Tool.m
//  0903 单例 - ARC
//
//  Created by 张思琦 on 15/9/3.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "Tool.h"

@implementation Tool


+ (instancetype)shareTool{
    return [[self alloc] init];
}

//init方法中没法控制实例只被创建一次
//因为要遵循系统的做法,在开始时执行self = [super init]
//- (instancetype)init{
//    self = [super init];
//    if (self) {
//        
//    }
//    return self;
//
//}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{

    /*****************不推荐的方法*********************/
    //缺点: 当执行多线程任务的时候,会出现问题
    //设定全局变量instance,保证创建的对象被其所指
    //static id instance0;
//    if (instance0 == nil) {
//        NSLog(@"分配内存空间");
//        instance0 = [super allocWithZone:zone];
//    }
//    return instance0;
    
    /*****************推荐的方法*********************/
    //使用局部变量
    //__block id instance1;
    //需要注意的是如果不使用全局变量,而使用局部变量,
    //首先这是一个类方法,先与alloc方法
    //由于局部变量没有被初始化过,也没有分配过内存,第二次进来的时候没法指向之前的对象
    //这样会造成问题
    
    //设定全局变量instance,保证创建的对象被其所指
    static id instance0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"分配内存空间");
        instance0 = [super allocWithZone:zone];
    });
    return instance0;
}

#pragma mark - NSCopying协议中的方法
- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

#pragma mark - NSMutableCopying协议中的方法
- (id)mutableCopyWithZone:(NSZone *)zone
{
    return self;
}


@end


