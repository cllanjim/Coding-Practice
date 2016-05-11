//
//  SQOther.m
//  MJExtension的映射机制
//
//  Created by 张思琦 on 16/3/25.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "SQOther.h"
#import <MJExtension.h>

@implementation SQOther

//+ (NSDictionary *)mj_replacedKeyFromPropertyName{
//
//    return @{@"sqName":@"sq_name",
//             @"sqAge":@"sq_age"
//             };
//}

//+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName{
//    //用于保存模型属性类中最终生成的属性名
//    NSMutableString *key = [NSMutableString string];
//
//    for (NSUInteger i = 0; i < propertyName.length; i++) {
//        unichar c = [propertyName characterAtIndex:i];
//        
//        if (c >= 'A' && c <= 'Z'){
//            [key appendString:@"_"];
//            [key appendFormat:@"%c",c + 32];
//        }else{
//            [key appendFormat:@"%c",c];
//        }
//    }
//    return key;
//}


+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName{
    return [propertyName mj_underlineFromCamel];
}

@end
