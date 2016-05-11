//
//  SQModelOfCarInfo.h
//  0805 添加索引条
//
//  Created by 张思琦 on 15/8/8.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface SQModelOfCarInfo : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, strong) UIImage *image;


-(UIImage *)image;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)modelOfCarInfoWithDict:(NSDictionary *)dict;

+ (NSArray *)groupOfCarInfoWithArray:(NSArray *)array;

@end
