//
//  CellModel.m
//  0904 多图片下载的优化
//
//  Created by 张思琦 on 15/9/4.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "CellModel.h"

@implementation CellModel

- (instancetype)initWihtDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)cellModelWithDict:(NSDictionary *)dict{
    return [[self alloc] initWihtDict:dict];    
}


@end
