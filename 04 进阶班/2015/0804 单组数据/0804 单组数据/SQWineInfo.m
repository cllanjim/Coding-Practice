//
//  SQWineInfo.m
//  0804 单组数据
//
//  Created by 张思琦 on 15/8/7.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "SQWineInfo.h"

@implementation SQWineInfo



- (UIImage *)imageOfWine{
    return [UIImage imageNamed:self.image];
}



- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)wineInfoWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

+ (NSArray *)groupOfWineInfo{
    NSArray *groupOfplist = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"wine" ofType:@"plist"]];
    NSMutableArray *groupOfModel = [NSMutableArray array];
    
    for (NSDictionary *instanceOfplist in groupOfplist) {
        SQWineInfo *instanceOfModel = [SQWineInfo wineInfoWithDict:instanceOfplist];
        [groupOfModel addObject:instanceOfModel];
    }
    
    return groupOfModel;
    
    
}

@end
