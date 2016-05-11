//
//  main.m
//  List 8-6
//
//  Created by 张思琦 on 15/6/11.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

//ClassA的定义

@interface ClassA : NSObject
{
    int x;//将由子类继承
}

- (void)initVar;

@end
/////////////////////////////
@implementation ClassA
- (void)initVar
{
    x = 100;
}

@end

//ClassB的定义

@interface ClassB : ClassA

- (void)initVar;
- (void)printVar;

@end
//////////////////////////////
@implementation ClassB

- (void)initVar
{
    x = 200;
}

- (void)printVar
{
    NSLog(@"x = %i",x);
}
@end


///////////////////////////////
int main(int argc, const char * argv[]) {
    @autoreleasepool {

        ClassB *b = [[ClassB alloc] init];
        [b initVar];
        [b printVar];
        
        NSLog(@"Hello, World!");
    }
    return 0;
}
