//
//  SQModelOfSectionInfo.h
//  0805 添加索引条
//
//  Created by 张思琦 on 15/8/8.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQModelOfSectionInfo : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSArray *groupOfCarInfo;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)modelOfSectionInfo:(NSDictionary *)dict;

+ (NSArray *)groupOfSectionInfo;


@end
