//
//  SQModelOfCarInfo.m
//  0804 在UITableView中使用数据模型
//
//  Created by 张思琦 on 15/8/7.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "SQModelOfCarInfo.h"

@implementation SQModelOfCarInfo

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
    
}


+ (instancetype)carInfoWihtDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}


- (UIImage *)image
{
    return [UIImage imageNamed:self.icon];
}

@end
