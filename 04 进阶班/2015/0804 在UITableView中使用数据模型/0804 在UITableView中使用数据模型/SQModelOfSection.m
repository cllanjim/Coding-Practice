//
//  SQModelOfSection.m
//  0804 在UITableView中使用数据模型
//
//  Created by 张思琦 on 15/8/7.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "SQModelOfSection.h"
#import "SQModelOfCarInfo.h"

@implementation SQModelOfSection


- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        [self setValue:dict[@"header"] forKeyPath:@"titleOfHeader"];
        [self setValue:dict[@"footer"] forKeyPath:@"titleOfFooter"];
        
        NSArray *groupOfCarsInfo = dict[@"cars"];
        NSMutableArray *groupOfModel = [NSMutableArray array];
        
        for (NSDictionary *instanceOfCarsInfo in groupOfCarsInfo) {
            SQModelOfCarInfo *instanceOfModel = [SQModelOfCarInfo carInfoWihtDict:instanceOfCarsInfo];
            [groupOfModel addObject:instanceOfModel];
        }
        _groupOfModel = groupOfModel;
 
    }
 
    
    return self;
}

+ (instancetype)sectionWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}


+ (NSArray *)groupOfSectionInfo{
    NSArray *groupOfPlist = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cars" ofType:@"plist"]];
    NSMutableArray *groupOfModel = [NSMutableArray array];
    
    for (NSDictionary *instaceOfPlist in groupOfPlist) {
        SQModelOfSection *instaceOfModel = [SQModelOfSection sectionWithDict:instaceOfPlist];
        [groupOfModel   addObject:instaceOfModel];
    }

    return groupOfModel;

}


@end
