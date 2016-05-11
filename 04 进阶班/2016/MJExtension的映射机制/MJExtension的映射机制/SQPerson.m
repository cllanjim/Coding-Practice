//
//  SQPerson.m
//  MJExtension的映射机制
//
//  Created by 张思琦 on 16/3/25.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "SQPerson.h"
#import <MJExtension.h>


@implementation SQPerson

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{
             @"clothes":@"SQClothes",
             @"books": @"SQBook"
             };
    
    return @{
             @"clothes":[SQClothes class],
             @"books": [SQBook class]
             };
    
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"personID" : @"id",
             @"name" : @[@"name", @"nickname"],
             @"other" : @"other.habbits[0].sports"
             };
}

@end
