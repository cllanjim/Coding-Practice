//
//  main.m
//  typedef
//
//  Created by 张思琦 on 15/6/29.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

//函数指针的定义
typedef int (*funPointer)(int b);

//block的定义
//1.block指针的定义
typedef int(^BlockPointer)(int) ;
//2.传入函数的block
typedef int(^setFunInBlock)(int, funPointer) ;
//3.传入block的block
typedef int(^setBlockInBlock)(int, BlockPointer);


//fun的定义
//1.能给返回int型的函数
int setFun (int x)
{
    
    return x;
}
//2.设计一个能给接受block作为参数的函数
int setBlockInFun(int a, BlockPointer block)
{
    return block(a);
}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
    
        //问题1: 在block中如何传入一个带有返回值且有参数的函数? Finish!
        
        //实现setFunInBlock块的功能,在形参中传入一个函数
        setFunInBlock block1 = ^(int a, funPointer test){
            return test(a);
        };
        //设置一个指向函数的函数指针
        funPointer test = setFun;
        NSLog(@"%i",block1(2,test));
        
        //问题2: 在函数中如何传入一个带有返回值且有参数的block? Finish!
        
        //定义一个block,并为其设定功能
        BlockPointer block2 = ^(int a){
            return a;
        };
        //设置一个指向block的block指针
        BlockPointer block3 = block2;
        NSLog(@"%i",setBlockInFun(5,block3));
        
        //问题3 :在block中传入一个带有返回值且有参数的block?
        BlockPointer block4 = ^(int a){
            return a;
        };
        
        setBlockInBlock block5 = ^(int a, BlockPointer test){
            return test(a);
        };
        
        NSLog(@"%i", block5(6,block4));

    
    }
    return 0;
}
