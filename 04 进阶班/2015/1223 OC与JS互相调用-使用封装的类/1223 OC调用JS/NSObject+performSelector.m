//
//  NSObject+performSelector.m
//  1224 NSInvocation
//
//  Created by 张思琦 on 15/12/25.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "NSObject+performSelector.h"

@implementation NSObject (performSelector)

- (id)performSelector:(SEL)aSelector withObjects:(NSArray *)objects{
    //1 创建签名
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:aSelector];
    
    //判断传入的参数是否正确
    if(signature == nil){
        //如果传入的方法与类不相符就会导致签名致为nil
        NSString *reason = [NSString stringWithFormat:@" -[%@ %@]:  unrecognized selector sent to instance", [self class], NSStringFromSelector(aSelector)];
        //NSException用于对异常的操作并保存异常的相关信息
        @throw [[NSException alloc] initWithName:@"出现错误" reason:reason userInfo:nil];
    }
    
    //2 创建NSInvocation对象
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    
    
    //3 设置invocation的相关属性
    invocation.target = self;
    invocation.selector = aSelector;
    
    //设置invocation的对象的参数
    //正常情况下参数数组和签名数组中元素应该一致
    //但在传入参数数据错误的情况下，如果直接遍历参数数组中的参数个数会出现错误
    //参数数组元素个数>签名数组元素个数 应当使用签名数组元素中的个数，否则赋值会超出方法本身的参数数量边界
    //参数数组元素个数<签名数组元素个数 应当使用参数数组元素中的个数，否则赋值会出现从参数数组中无法取出值的情况
    
    //签名数组中元素个数
    NSUInteger argumentNumber = signature.numberOfArguments - 2;
    NSUInteger objectsNumber = objects.count;
    //取argumentNumber和objectsNumber中较小的参数作为循环上限
    NSUInteger count = MIN(argumentNumber, objectsNumber);

    for (int i = 0; i < count; i++) {
        NSObject *argument = objects[i];
        //判断数组中传入的参数是否为空对象
        if([argument isKindOfClass:[NSNull class]]){
            argument = nil;
        }
        //设定参数
        [invocation setArgument:&argument atIndex: 2 + i];
    }
    
    //4 启动方法
    [invocation invoke];
    
    //设置用于接受返回值的对象result
    id result = nil;
    
    //如果方法签名的返回值长度不为零,就说明有返回值
//    if(signature.methodReturnLength != 0){
//        [invocation getReturnValue:&result];
//    }
    
    //如果方法签名的返回值类型不为,就说明有返回值
    if([[NSString stringWithCString:signature.methodReturnType encoding:NSUTF8StringEncoding] isEqualToString:@"v"] != 1){
        [invocation getReturnValue:&result];
    }
    
    return result;

}






@end
