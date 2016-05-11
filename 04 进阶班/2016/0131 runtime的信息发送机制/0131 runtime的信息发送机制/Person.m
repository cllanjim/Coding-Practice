//
//  Person.m
//  0131 runtime的信息发送机制
//
//  Created by 张思琦 on 16/1/31.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "Person.h"

@implementation Person
+ (void)run{
    NSLog(@"类方法----run");
}
- (void)run{
    NSLog(@"对象方法----run");
}

+ (void)eat:(id)object{
    NSLog(@"吃的是%@",object);
}



@end
