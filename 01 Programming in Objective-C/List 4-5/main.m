//
//  main.m
//  List 4-5
//
//  Created by 张思琦 on 15/6/10.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        float f1 = 123.125, f2;
        int i1, i2 = -150;
        
        i1 = f1;//浮点数到整数的转换
        NSLog(@"%f assigned to an int produces %i", f1 , i1);
        
        f1 = i1;//整数到浮点数的转换
        NSLog(@"%i assigned to an int produces %f", i1 , f1);
        
        f1 = i2 / 100;//整数除以整数
        NSLog(@"%i is divided by 100 produces %f", i1 , f1);
        
        f2 = i2 / 100.0;//整数除以浮点数
        NSLog(@"%i is divided by 100 produces %f", i2 , f2);
        
        f2 = (float) i2 / 100;//类型强制转换运算符
        NSLog(@"(float)%i is divided by 100 produces %f", i2 , f2);
        

        
        
        
        NSLog(@"Hello, World!");
    }
    return 0;
}
