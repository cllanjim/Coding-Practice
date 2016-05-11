//
//  Tool.h
//  0903 单例 - MRC
//
//  Created by 张思琦 on 15/9/3.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tool : NSObject <NSCopying, NSMutableCopying>

//创建类工厂方法
+ (instancetype)shareTool;


@end
