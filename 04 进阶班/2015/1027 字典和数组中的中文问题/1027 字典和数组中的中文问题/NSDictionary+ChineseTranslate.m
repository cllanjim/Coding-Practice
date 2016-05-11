//
//  NSDictionary+ChineseTranslate.m
//  1027 字典和数组中的中文问题
//
//  Created by 张思琦 on 15/10/28.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "NSDictionary+ChineseTranslate.h"

@implementation NSDictionary (ChineseTranslate)

- (NSString *)descriptionWithLocale:(id)locale{
    //1创建NSMutableString用来保存输出结果
    NSMutableString *string = [NSMutableString string];
    //2输出JSON数据中最外层的字典
    [string appendFormat:@"{\n"];
    //3迭代输出JSON数据中的Key和Value值
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        //\t表示一个占位符
        [string appendFormat:@"\t %@ = %@, \n", key, obj];
    }];
    
    //判断当前字典是否存在key值
    if (self.allKeys.count > 0) {
        NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
        [string deleteCharactersInRange:range];
    }

    
    //4 输出JSON数据最外层的结尾
    [string appendFormat:@"}\n"];

    return string;
}

@end
