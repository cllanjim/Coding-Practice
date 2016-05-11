//
//  ProvincesDateModel.m
//  1004 PickerView综合应用
//
//  Created by 张思琦 on 15/10/11.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ProvincesDateModel.h"

@implementation ProvincesDateModel

+ (instancetype)provinceDataModelWithDict:(NSDictionary *)dict
{
    ProvincesDateModel *dataModel = [[ProvincesDateModel alloc] init];
    [dataModel setValuesForKeysWithDictionary:dict];
    return dataModel;
}

@end
