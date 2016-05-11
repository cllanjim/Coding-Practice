//
//  Tool.h
//  0903 单例 - ARC
//
//  Created by 张思琦 on 15/9/3.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tool : NSObject <NSCopying,NSMutableCopying>

//提供一个类工厂方法,以share或者default开头

+ (instancetype)shareTool;

@end
