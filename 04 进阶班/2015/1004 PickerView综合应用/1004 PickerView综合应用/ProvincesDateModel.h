//
//  ProvincesDateModel.h
//  1004 PickerView综合应用
//
//  Created by 张思琦 on 15/10/11.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProvincesDateModel : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *cities;

+ (instancetype)provinceDataModelWithDict:(NSDictionary *)dict;

@end
