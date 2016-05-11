//
//  NSObject+ConvertMethod.m
//  0203 自动生成属性代码
//
//  Created by 张思琦 on 16/2/4.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "NSObject+ConvertMethod.h"
#import <objc/message.h>

@implementation NSObject (ConvertMethod)

//利用runtime技术实现字典转模型
//主要思路:通过遍历类中的所以属性,将属性值与字典中key对应的值关联
+ (instancetype)getModelWithDict:(NSDictionary *)dict{
    
    id objc = [[self alloc] init];
    
    //class_copyIvarList(__unsafe_unretained Class cls, unsigned int *outCount)
    //该函数用于获取指定类的属性列表,
    //该函数的返回值为一个包含Ivar类型指针的数组,每个指针指向当前类的属性
    //返回值Ivar *本质上是指向该数组的第0个变量
    //__unsafe_unretained Class cls 需要拷贝那个类的属性列表
    //unsigned int *outCount 记录属性列表数量的变量地址
    
    //用于记录属性列表数量的变量地址
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList(self, &count);
    //注意点:
    // 1.Ivar *ivarList是一个指向成员变量的指针,默认指向第0个变量
    // Ivar *ivars; 指向Ivar类型的变量
    // 举例:int *p; 指向int类型的变量

    // 2.一个Ivar就代表一个成员变量
    // Ivar ivar = *ivars;
    // Ivar ivar2 = *(ivars + 1);
    // NSLog(@"%s %s", ivar_getName(ivar), ivar_getName(ivar2));
    
    // 3.如果函数名中包含了copy\new\retain\create等字眼，那么这个函数返回的数据就需要手动释放
    // free(ivars);
    
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
        //获取属性名称
        //propertyName的值为_reposts_count
        //ivar_getName(Ivar v)函数的返回值类型为C语言的string类型,其值为实例变量v的名称
        NSString *propertyName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        //key的值的样式类似为 reposts_count
        NSString *key = [propertyName substringFromIndex:1];

//        //获取属性类型
        //propertyType的值的样式类似为 @"NSString"
        NSString *propertyType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];

        //获取字典中的value
        id value = dict[key];
        
        //二级转换:判断字典中的value值为NSDictionary类型时,是否需要转换?!
        //解释:
        //value是从字典中获取属性的具体值
        //propertyType是从当前类中获取属性类型
        //当从字典中获取为的值类型为NSDictionary,且当前类中的属性类型中不包含"NS"(即自身属性类型不是NSDictionary,那不就是自定义类型了么!!!)
        if ([value isKindOfClass:[NSDictionary class]] && ![propertyType containsString:@"NS"]) {
            //删除 @"    (前面)
            NSRange frontRange = [propertyType rangeOfString:@"\""];
            //因为frontRange.location只能定位到",而截取的字符从后一位开始,所以要加上frontRange.length
            propertyType  = [propertyType substringFromIndex:frontRange.location + frontRange.length];
            
            //删除 "    (后面)
            NSRange backRange = [propertyType rangeOfString:@"\""];
            propertyType = [propertyType substringToIndex:backRange.location];
            //备注:此时获得的propertyType为自定义的类型的字符串
            
            //获取自定义类型
            Class modelClass = NSClassFromString(propertyType);
            
            if (modelClass != nil) {
                //将从一级字典中获取到的二级字典数据转换为自定义的数据类型
                value = [modelClass getModelWithDict:dict[key]];
            }
            
        }
        
        
        //三级转换:判断字典中的value值为NSArray类型时,是否需要转换?!
        
        
        
        
        
        
        if (value != nil) {
            //给模型赋值
            [objc setValue:value forKey:key];
        }
        
        
    //如果函数名中包含了copy\new\retain\create等字眼，那么这个函数返回的数据就需要手动释放
    }
    
    return objc;
}

@end
