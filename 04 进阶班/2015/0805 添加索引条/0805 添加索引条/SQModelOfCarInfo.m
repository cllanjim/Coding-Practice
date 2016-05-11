//
//  SQModelOfCarInfo.m
//  0805 添加索引条
//
//  Created by 张思琦 on 15/8/8.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "SQModelOfCarInfo.h"

@implementation SQModelOfCarInfo

-(UIImage *)image{
    return [UIImage imageNamed:self.icon];
}


- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)modelOfCarInfoWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

+ (NSArray *)groupOfCarInfoWithArray:(NSArray *)array{
    NSMutableArray *groupOfCarInfo = [NSMutableArray array];
    
    for (NSDictionary *instanceOfArray in array) {
        SQModelOfCarInfo *instaceOfModel = [SQModelOfCarInfo modelOfCarInfoWithDict:instanceOfArray];
        [groupOfCarInfo addObject:instaceOfModel];
    }
    
    return groupOfCarInfo;
}


@end
