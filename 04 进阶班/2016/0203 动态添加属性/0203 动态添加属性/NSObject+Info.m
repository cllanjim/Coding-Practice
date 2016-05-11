//
//  NSObject+Info.m
//  0203 动态添加属性
//
//  Created by 张思琦 on 16/2/3.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "NSObject+Info.h"
#import <objc/message.h>

@implementation NSObject (Info)


static const char *key = "describe";
//set方法的实现
- (void)setDescribe:(NSString *)describe{
    //objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy)
    //id object 给哪个对象添加属性
    //const void *key 用于添加关联的key值(void *类似于id,但不等价于id)
    //id value 与key相对于的值(当传入值为nil的时候,解除关联)
    //objc_AssociationPolicy policy 关联的策略
        //OBJC_ASSOCIATION_ASSIGN = 0,
        //OBJC_ASSOCIATION_RETAIN_NONATOMIC = 1,
        //OBJC_ASSOCIATION_COPY_NONATOMIC = 3,
        //OBJC_ASSOCIATION_RETAIN = 01401,
        //OBJC_ASSOCIATION_COPY = 01403
    objc_setAssociatedObject(self, key, describe, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//get方法的实现
- (NSString *)description{
    //objc_getAssociatedObject(id object, const void *key)
    //id object 给哪个对象添加属性
    //const void *key 用于添加关联的key值(void *类似于id,但不等价于id)
    return objc_getAssociatedObject(self, key);
}


@end
