//
//  main.m
//  List 8-4
//
//  Created by 张思琦 on 15/6/11.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYPoint.h"
#import "Rectangle.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Rectangle *myRect = [[Rectangle alloc] init];
        XYPoint *myPoint = [[XYPoint alloc] init];
        
        [myPoint setX:100 andY:200];
        
        [myRect setWidth:5 andHeight:8];
        myRect.origin = myPoint;
        
        NSLog(@"Origin at (%i %i)", myRect.origin.x, myRect.origin.y);
       
        [myPoint setX:50 andY:50];
        NSLog(@"Origin at (%i %i)", myRect.origin.x, myRect.origin.y);
        
        //NSLog(@"Area = %i, Perimeter = %i", [myRect area], [myRect perimeter]);
        
        NSLog(@"Hello, World!");
    }
    return 0;
}
