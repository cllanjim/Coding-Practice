//
//  SQModelOfData.m
//  0802 图片轮播器(功能封装)
//
//  Created by 张思琦 on 15/8/6.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "SQModelOfData.h"

@implementation SQModelOfData

//提供自定义构造方法
- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    };
    return self;
}


//提供类工厂方法
+ (instancetype)modelOfDataWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}


//image的get方法
- (UIImage *)image
{
   return [UIImage imageNamed:self.imageName];

}


//imageView的get方法
- (UIImageView *)imageView
{
    return [[UIImageView alloc] initWithImage:self.image];

}

//根据plist文件自动生成模型对象的集合的方法
+ (NSArray *)groupOfImageView
{
    //取出plist中的数组
    NSArray *classOfPlist = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ImageNameList" ofType:@"plist"]];
    //创建用于保存对象的数组
    NSMutableArray *classOfModel = [NSMutableArray array];
    //转换字典数据为模型数据并保存到数组中
    for (NSDictionary *instanceOfPlist in classOfPlist) {
        SQModelOfData *instanceOfModel = [SQModelOfData modelOfDataWithDict:instanceOfPlist];
        [classOfModel addObject:instanceOfModel];
    }
    //返回数组
    return classOfModel;
}


@end
