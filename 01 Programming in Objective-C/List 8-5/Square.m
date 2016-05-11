//
//  Square.m
//  Programming in Objective-C
//
//  Created by 张思琦 on 15/6/11.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "Square.h"

@implementation Square


- (void)setSide:(int)s
{
    [self setWidth:s andHeight:s];
}


- (int)side;
{
    return self.width;
    //return [(Square *) width];
    
}
@end