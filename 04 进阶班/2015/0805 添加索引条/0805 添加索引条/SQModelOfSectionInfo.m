//
//  SQModelOfSectionInfo.m
//  0805 添加索引条
//
//  Created by 张思琦 on 15/8/8.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "SQModelOfSectionInfo.h"
#import "SQModelOfCarInfo.h"
@implementation SQModelOfSectionInfo


- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        [self setValue:dict[@"title"] forKeyPath:@"title"];
        self.groupOfCarInfo = [SQModelOfCarInfo groupOfCarInfoWithArray:dict[@"cars"]];
    }
    return self;
}

+ (instancetype)modelOfSectionInfo:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
    
}

+ (NSArray *)groupOfSectionInfo{
    NSArray *classOfplist = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cars" ofType:@"plist"]];
                             
    NSMutableArray *classOfModel = [NSMutableArray array];
    
    for (NSDictionary *instanceOfplist in classOfplist) {
        SQModelOfSectionInfo *instanceOfModel = [SQModelOfSectionInfo modelOfSectionInfo:instanceOfplist];
        [classOfModel addObject:instanceOfModel];
    }
    return classOfModel;
}

@end
