//
//  main.m
//  List 15-5
//
//  Created by 张思琦 on 15/6/21.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *str1 = @"This is string A";
        NSString *str2 = @"This is string B";
        NSString *res;
        NSRange subRange;
        
        //从字符串中提取前三个字符
        
        res = [str1 substringToIndex:3];
        NSLog(@"First 3 chars of str1: %@", res);
        
        //提取从索引5开始知道结尾的字符串
        res = [str1 substringFromIndex:5];
        NSLog(@"Chars from index 5 of str1: %@",res);
        
        //提取从索引5开始到13的字符串(6个字符)
        res = [[str1 substringFromIndex:8] substringToIndex:6];
        NSLog(@"Char from index 8 through 13 :%@",res);
        
        //更简单的方法
        res = [str1 substringWithRange:NSMakeRange(8, 6)];
        NSLog(@"Chars from index 8 through 13: %@",res);
        
        //从一个字符串中查找另一个字符串
        subRange = [str1 rangeOfString:@"string A"];
        NSLog(@"String is at index %lu, length is %lu",subRange.location,subRange.length);
        
        subRange = [str1 rangeOfString:@"string B"];
        
        if(subRange.location == NSNotFound)
            NSLog(@"String not found");
        else
            NSLog(@"String is at index %lu, length is %lu",subRange.location, subRange.length);
        
        
        
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
