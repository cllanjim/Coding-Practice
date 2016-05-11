//
//  StatusModel.m
//  0203 自动生成属性代码
//
//  Created by 张思琦 on 16/2/3.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "StatusModel.h"

@implementation StatusModel

#pragma mark - 初始化方法
- (StatusModel *)initStatusModelWithDict:(NSDictionary *)dict{
    //创建statusModel对象
    self = [super init];
    if (self != nil) {
        //如果对象不为空,就赋值
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (StatusModel *)statusModelWithDict:(NSDictionary *)dict{
    return [[self alloc] initStatusModelWithDict:dict];
}

//当字典中的key值与模型中的属性名不一致时,会调用该方法
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
        
    if ([key isEqualToString:@"id"]) {
        self.ID = [value integerValue];
    }
    
}


@end
