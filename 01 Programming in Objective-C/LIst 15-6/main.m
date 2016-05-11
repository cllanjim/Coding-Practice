//
//  main.m
//  LIst 15-6
//
//  Created by 张思琦 on 15/6/21.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *str1 = @"This is string A";
        NSString *search, *replace;
        NSMutableString *mstr;
        NSRange substr;
        
        //从不可变字符串创建可变字符串
        mstr = [NSMutableString stringWithFormat:str1];
        NSLog(@"%@",mstr);
        
        //输入字符
        [mstr insertString:@"mutable" atIndex:7];
        NSLog(@"%@",mstr);
        
        //输入末尾进行有效拼接
        [mstr insertString:@"and string B" atIndex:[mstr length]];
        NSLog(@"%@",mstr);
        
        //直接使用appendString
        [mstr appendString:@" and string C"];
        NSLog(@"%@",mstr);
        
        //根据范围删除子字符串
        [mstr deleteCharactersInRange:NSMakeRange(16, 13)];
        NSLog(@"%@",mstr);
        
        //查找然后将其删除
        substr = [mstr rangeOfString:@"string B and"];
        
        if (substr.location != NSNotFound) {
            [mstr deleteCharactersInRange: substr];
            NSLog(@"%@",mstr);
        }
        
        //直接设置为可变的字符串
        [mstr setString:@"This is string A"];
        NSLog(@"%@",mstr);
        
        //替换一些字符
        [mstr replaceCharactersInRange:NSMakeRange(8, 8) withString:@"a mutable string"];
        
        //查找和替换
        search = @"THis is";
        replace = @"An example of";
        
        substr = [mstr rangeOfString:search];
        
        if (substr.location != NSNotFound) {
            [mstr replaceCharactersInRange:substr withString:replace];
            NSLog(@"%@",mstr);
        }
        
        
        //查找和替换所有的匹配项
        search = @"a";
        replace = @"X";
    
        substr = [mstr rangeOfString:search];
        while (substr.location != NSNotFound) {
            [mstr replaceCharactersInRange:substr withString:replace];
            substr = [mstr rangeOfString:search];
        }
        
        
        [mstr replaceOccurrencesOfString:search
                              withString:replace
                                 options:nil
                                   range:NSMakeRange(0, [mstr length])];
        
        
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
