//
//  Single.h
//  0903 单例的宏抽取
//
//  Created by 张思琦 on 15/9/3.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//



//生成 定义类工厂方法 的宏
#define SingleInterface(name)  +(instancetype)share##name

//生成 实现各种方法 宏
#if __has_feature(objc_arc)

//在ARC下生成以下代码
#define SingleImplementation(name)  +(instancetype)share##name  \
{                                                               \
return [[self alloc] init];                                     \
}                                                               \
+ (instancetype)allocWithZone:(struct _NSZone *)zone            \
{                                                               \
static id instance;                                             \
static dispatch_once_t onceToken;                               \
dispatch_once(&onceToken, ^{                                    \
instance = [super allocWithZone:zone];                          \
});                                                             \
return instance;                                                \
}                                                               \
- (id)copyWithZone:(NSZone *)zone                               \
{                                                               \
return self;                                                    \
}                                                               \
- (id)mutableCopyWithZone:(NSZone *)zone                        \
{                                                               \
return self;                                                    \
}

#else

//在MRC下生成以下代码
#define SingleImplementation(name)  +(instancetype)share##name  \
{                                                               \
return [[self alloc] init];                                     \
}                                                               \
+ (instancetype)allocWithZone:(struct _NSZone *)zone            \
{                                                               \
static id instance;                                             \
static dispatch_once_t onceToken;                               \
dispatch_once(&onceToken, ^{                                    \
instance = [super allocWithZone:zone];                          \
});                                                             \
return instance;                                                \
}                                                               \
- (id)copyWithZone:(NSZone *)zone                               \
{                                                               \
return self;                                                    \
}                                                               \
- (id)mutableCopyWithZone:(NSZone *)zone                        \
{                                                               \
return self;                                                    \
}                                                               \
- (oneway void)release                                          \
{}                                                              \
- (instancetype)retain                                          \
{                                                               \
return self;                                                    \
}                                                               \
- (NSUInteger)retainCount                                       \
{                                                               \
return MAXFLOAT;                                                \
}
#endif