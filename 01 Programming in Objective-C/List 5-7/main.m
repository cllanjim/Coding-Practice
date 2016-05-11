//
//  main.m
//  List 5-7
//
//  Created by 张思琦 on 15/6/10.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

//找到两个非负整数的最大公约数

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        unsigned int u, v, temp;
        
        NSLog(@"Please type in two nonnegative integers:");
        scanf("%u%u",&u,&v);
        
        while( 0 != v ){
            temp = u % v;
            u = v;
            v = temp;
        }
        
        NSLog(@"Their greatest common divisor is %u", u);
        
        NSLog(@"Hello, World!");
    }
    return 0;
}
