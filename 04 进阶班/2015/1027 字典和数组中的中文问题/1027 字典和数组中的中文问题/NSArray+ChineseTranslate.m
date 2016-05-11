//
//  NSArray+ChineseTranslate.m
//  1027 字典和数组中的中文问题
//
//  Created by 张思琦 on 15/10/28.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "NSArray+ChineseTranslate.h"

@implementation NSArray (ChineseTranslate)

- (NSString *)descriptionWithLocale:(id)locale{
    //1创建NSMutableString用来保存输出结果
    NSMutableString *string = [NSMutableString string];
    //2输出JSON数据中最外层的数组的开始
    [string appendFormat:@"(\n"];
    //3迭代输出JSON数据中的Key和Value值
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [string appendFormat:@"\t%@,\n",obj];
    }];
    
    //判断NSArray中元素个数
    if(self.count > 0){
        NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
        [string deleteCharactersInRange:range];
    }
    
    //4 输出JSON数据最外层的数组的结尾
    [string appendFormat:@")\n"];
    
    return string;
}



@end
