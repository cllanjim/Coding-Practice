//
//  SQSectionModel.m
//  0825 案例 - 彩票
//
//  Created by 张思琦 on 15/8/30.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "SQSectionModel.h"

@implementation SQSectionModel


+ (instancetype)sectionModelWithHeaderTitle:(NSString *)header FooterTitle:(NSString *)footer{
    
    SQSectionModel *model = [[SQSectionModel alloc] init];
    model.headerTitle = header;
    model.footerTitle = footer;
    return model;

}


@end
