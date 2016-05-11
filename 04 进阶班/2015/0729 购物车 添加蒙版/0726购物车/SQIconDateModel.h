//
//  SQIconDateModel.h
//  0726购物车
//
//  Created by 张思琦 on 15/7/27.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SQIconDateModel : NSObject

@property (nonatomic, copy)NSString *iconName;
@property (nonatomic, copy)NSString *imageName;

@property (nonatomic, strong)UIImage *iconImage;

//@property (nonatomic, strong)NSArray *classOfModel;


//自定义构造方法
- (instancetype)initWithDict:(NSDictionary *)dict;

//类工厂方法
+ (instancetype)iconDateModel:(NSDictionary *)dict;

//用于
+ (NSMutableArray *)groupOfModel;

@end
