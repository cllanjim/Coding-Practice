//
//  main.m
//  List 15-4
//
//  Created by 张思琦 on 15/6/18.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSString *str1 = @"This is string A";
        NSString *str2 = @"This is string B";
        NSString *res;
        NSComparisonResult compareResult;
        
        //计算字符串中的字符
        NSLog(@"Length of str1: %lu", [str1 length]);
        
        //将一个字符串复制到另一个字符串
        res = [NSString stringWithFormat:str1];
        NSLog(@"copy:%@", res);
        
        //将一个字符串复制到另一个字符串的末尾
        str2 = [str1 stringByAppendingString:str2];
        NSLog(@"Concatentation:%@",str2);
        
        //验证两个字符是否相等
        if ([str1 isEqualToString:res] == YES)
            NSLog(@"str1 == res");
        else
            NSLog(@"str1 != res");
        
        //验证一个字符串是否小于,等于或大于另一个字符
        compareResult = [str1 compare:str2];
        
        if (compareResult == NSOrderedAscending)
            NSLog(@"str1 < str2");
        else if (compareResult == NSOrderedSame)
            NSLog(@"str1 == str2");
        else
            NSLog(@"str1 > str2");
        
        //将字符串转换为大写
        
        res = [str1 uppercaseString];
        NSLog(@"Uppercase conversion: %s", [res UTF8String]);
        
        //将字符串转换为小写
        res = [str1 lowercaseString];
        NSLog(@"Lowercase conversion: %@", res);
        
        NSLog(@"Original string: %@",str1);
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
