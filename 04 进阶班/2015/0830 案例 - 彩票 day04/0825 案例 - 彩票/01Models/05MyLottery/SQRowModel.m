//
//  SQRowModel.m
//  0825 案例 - 彩票
//
//  Created by 张思琦 on 15/8/30.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "SQRowModel.h"

@implementation SQRowModel


+ (instancetype)rowModelWithTitle:(NSString *)title subTitle:(NSString *)subTitle
{
    SQRowModel *model = [[self alloc] init];
    model.title = title;
    model.subTitle = subTitle;
    return model;
}


@end
