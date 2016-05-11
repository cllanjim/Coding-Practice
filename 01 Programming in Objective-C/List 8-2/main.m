//
//  main.m
//  List 8-2
//
//  Created by 张思琦 on 15/6/11.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Rectangle.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {

        Rectangle *myRect = [[Rectangle alloc] init];
        
        //NO.1
        [myRect setWidth:5 andHeight: 8];

        //NO.2
        //        [myRect setWidth:5];
        //        [myRect setHeight:8];
        
        //NO.3
        //myRect.width = 5;
        //myRect.height = 8;
        
        
        NSLog(@"Rectangle: w = %i, h = %i", myRect.width, myRect.height);
        
        NSLog(@"Area = %i, Perimeter = %i", [myRect area], [myRect perimeter]);
        
        
        
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
