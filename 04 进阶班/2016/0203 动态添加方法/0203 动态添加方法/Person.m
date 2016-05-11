//
//  Person.m
//  0203 动态添加方法
//
//  Created by 张思琦 on 16/2/3.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "Person.h"
#import <objc/message.h>

@implementation Person

//当一个类对象调用未实现的方法时,会进入该方法
+ (BOOL)resolveClassMethod:(SEL)sel{

    NSLog(@"%s",__func__);
    
    return [super resolveClassMethod:sel];
}

//在使用动态方法添加方法时,addMethod方法调用的函数需要至少提供两个参数id self,SEL _cmd
// self指方法调用者
//_cmd指方法的编号
void eat(id self,SEL _cmd){
    NSLog(@"%@----%@----", self, NSStringFromSelector(_cmd));
}

//当一个实例对象调用未实现的方法时,会进入该方法
+ (BOOL)resolveInstanceMethod:(SEL)sel{

    NSLog(@"%s",__func__);

    if (sel == @selector(eat)) {
    //class_addMethod(__unsafe_unretained Class cls, SEL name, IMP imp, const char *types)
    //__unsafe_unretained Class cls  需要添加方法的类
    //SEL name  方法的名称
    //IMP imp   方法的函数实现
    //const char *types 函数类型(返回值+参数类型)
    //"v@:"的涵义:v--->void @--->对象 :--->sel
        class_addMethod([self class], sel, (IMP)eat, "v@:");
    }
    
    return [super resolveInstanceMethod:sel];
}

@end
