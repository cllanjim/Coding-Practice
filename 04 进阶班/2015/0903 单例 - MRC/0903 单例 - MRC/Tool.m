//
//  Tool.m
//  0903 单例 - MRC
//
//  Created by 张思琦 on 15/9/3.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "Tool.h"

@implementation Tool

+ (instancetype)shareTool{

    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

- (id)copyWithZone:(NSZone *)zone{
    return self;
}

- (id)mutableCopyWithZone:(NSZone *)zone{
    return self;
}


#pragma mark - MRC特有的方法

- (oneway void)release{

}

-(instancetype)retain{
    return self;
}

-(NSUInteger)retainCount{
    return MAXFLOAT;
}

@end
