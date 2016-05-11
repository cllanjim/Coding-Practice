//
//  main.m
//  List 8-3
//
//  Created by 张思琦 on 15/6/11.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Square.h"


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Square *mySquare = [[Square alloc] init];
        
        [mySquare setSide:5];
        
        NSLog(@"Square s = %i",[mySquare side]);
        NSLog(@"Area = %i, Perimeter = %i",[mySquare area],[mySquare perimeter]);
        
        
        NSLog(@"Hello, World!");
    }
    return 0;
}
