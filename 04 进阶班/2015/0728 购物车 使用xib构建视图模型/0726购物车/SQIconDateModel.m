//
//  SQIconDateModel.m
//  0726购物车
//
//  Created by 张思琦 on 15/7/27.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "SQIconDateModel.h"

@implementation SQIconDateModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self){
        _iconName = dict[@"name"];
        _imageName = dict[@"icon"];
    };
    return self;
}

+ (instancetype)iconDateModel:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

- (UIImage *)iconImage
{
    UIImage *image = [UIImage imageNamed:self.imageName];
    _iconImage = image;
    return _iconImage;
}

+ (NSMutableArray *)groupOfModel{
    //使用plist文件加载
    //1.获取plist文件
            //获取路径
            NSString *path = [[NSBundle mainBundle] pathForResource:@"iconInfo" ofType:@"plist"];
            //根据路径生成Array
            NSArray *classOfDict = [NSArray arrayWithContentsOfFile:path];
    
    //2.初始化参数
            //用于接收根据模型转换后的对象的集合
            NSMutableArray *classOfModel = [NSMutableArray array];
            //plist中的对象
            NSMutableDictionary *instanceOfDict =[NSMutableDictionary dictionary];
    
            //以下内容放到这里会出错的原因是:
            //用于接收根据模型转换后的对象
            //SQIconDateModel *instanceOfModel = [[SQIconDateModel alloc] init];
    
    //3.读取plist文件的dict元素并赋值给SQIconDateModel模型中的实例对象
            for (instanceOfDict in classOfDict)
            {
                //用于接收根据模型转换后的对象
                SQIconDateModel *instanceOfModel = [[SQIconDateModel alloc] init];
    
                instanceOfModel.iconName = instanceOfDict[@"name"];
                instanceOfModel.imageName = instanceOfDict[@"icon"];
    
                [classOfModel addObject:instanceOfModel];
            }
    
    //4.将可变数组传递给自身属性iconInfo
            return  classOfModel;
}
@end
