//
//  SQModelOfSection.h
//  0804 在UITableView中使用数据模型
//
//  Created by 张思琦 on 15/8/7.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQModelOfSection : NSObject

@property (nonatomic, copy) NSString *titleOfHeader;
@property (nonatomic, copy) NSString *titleOfFooter;

//这里面存着的是CarInfo
@property (nonatomic, strong) NSArray *groupOfModel;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)sectionWithDict:(NSDictionary *)dict;


+ (NSArray *)groupOfSectionInfo;

@end
