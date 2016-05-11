//
//  Rectangle.h
//  Programming in Objective-C
//
//  Created by 张思琦 on 15/6/11.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#ifndef Programming_in_Objective_C_Rectangle_h
#define Programming_in_Objective_C_Rectangle_h

#import <Foundation/Foundation.h>

#import "XYPoint.h"
@interface Rectangle : NSObject

@property int width, height;


- (XYPoint *)origin;
- (void)setWidth:(int)w andHeight:(int)h;
- (void)setOrigin:(XYPoint *)pt;
- (int)area;
- (int)perimeter;

@end

#endif
