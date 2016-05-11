//
//  SQWineInfo.h
//  0804 单组数据
//
//  Created by 张思琦 on 15/8/7.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SQWineInfo : NSObject

@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *money;

@property (nonatomic, strong) UIImage *imageOfWine;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)wineInfoWithDict:(NSDictionary *)dict;

+ (NSArray *)groupOfWineInfo;


@end
