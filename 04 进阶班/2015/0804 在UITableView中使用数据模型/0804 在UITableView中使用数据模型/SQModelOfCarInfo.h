//
//  SQModelOfCarInfo.h
//  0804 在UITableView中使用数据模型
//
//  Created by 张思琦 on 15/8/7.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SQModelOfCarInfo : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;

@property (nonatomic, strong) UIImage *image;



- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)carInfoWihtDict:(NSDictionary *)dict;




@end
