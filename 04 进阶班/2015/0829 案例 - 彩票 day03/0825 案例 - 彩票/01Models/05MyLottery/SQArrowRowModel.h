//
//  SQArrowRowModel.h
//  0825 案例 - 彩票
//
//  Created by 张思琦 on 15/8/31.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "SQRowModel.h"

@interface SQArrowRowModel : SQRowModel


//用来保存cell中要跳转页面的类型
@property (nonatomic, assign) Class className;

@end
