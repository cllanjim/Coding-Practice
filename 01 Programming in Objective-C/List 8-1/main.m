//
//  main.m
//  List 8-1
//
//  Created by 张思琦 on 15/6/11.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

//----ClassA的定义

@interface ClassA : NSObject
{
    int x;
}

- (void) initVar;
@end

//-----ClassA的实现

@implementation ClassA

- (void) initVar
{
    x = 100;
}

@end

//-----ClassB的声明

@interface ClassB : ClassA

- (void)printVar;

@end

//-----ClassB的实现

@implementation ClassB

- (void)printVar
{
    NSLog(@"x = %i",x);
}

@end

//-----Program部分
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        ClassB *b = [[ClassB alloc] init];
        
        [b initVar];
        [b printVar];
        
        
        NSLog(@"Hello, World!");
    }
    return 0;
}
