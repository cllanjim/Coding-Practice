//
//  NationDataModel.m
//  1004 PickerView综合应用
//
//  Created by 张思琦 on 15/10/11.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "NationDataModel.h"

@implementation NationDataModel

- (instancetype)initNationDataModelWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
        //KVC的本质是将字典中的值转换为模型中的值
        //如果使用KVC进行字典转模型,一定要保证模型中的属性名与字典中的key值相同
        //[self setValuesForKeysWithDictionary:dict]在底层进行如下操作
        //1. 遍历字典中的所有key和Object
        [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            //key 字典的key        模型的属性名
            //obj 字典的Object值   模型的属性值
            //2. 将字典中的Object值赋给模型中对应key的属性值
            NSLog(@"%@   %@", key, obj);
            [self setValue:obj forKey:key];
        }];

        
    }
    return self;
}

+ (instancetype)nationDataModelWithDict:(NSDictionary *)dict{

    return [[self alloc] initNationDataModelWithDict:dict];
    
}

// setValue:forKey:方法的作用是给模型的属性赋值
//在底层进行如下操作
//以[self setValue:dict[@"icon"] forKey:@"icon"]为例
// 1.就会去模型中查找有没有setIcon方法,就直接调用这个set方法,给模型这个属性赋值[self setIcon:dict[@"icon"]]
// 2.接着就会去寻找有没有icon属性,如果有,就直接访问模型中icon = dict[@"icon"]
// 3.接着又会去寻找_icon属性,如果有,直接_icon = dict[@"icon"]
// 4.如果都找不到就会报错

- (void)setIcon:(NSString *)icon{
    _icon = [UIImage imageNamed:icon];
}
@end
