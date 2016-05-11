//
//  main.m
//  List 6-7
//
//  Created by 张思琦 on 15/6/10.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//


//对单个字符进行分类的程序
//  从键盘输入
#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        char c ;
        
        NSLog(@"Enter a single character:");
        scanf("   %c",&c);
        
        if ((c >='a' && c <= 'z') || (c >= 'A' && c <= 'Z')) {
            NSLog(@"It's an alphabetic character.");}
        else if (c >= '0' && c <= '9' ){
            NSLog(@"It's a digit.");}
        else{
            NSLog(@"It's a special character.");}
        
        
        NSLog(@"Hello, World!");
    }
    return 0;
}
