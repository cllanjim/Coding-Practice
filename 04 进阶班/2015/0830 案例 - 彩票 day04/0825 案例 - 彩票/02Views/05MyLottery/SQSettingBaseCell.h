//
//  SQSettingBaseCell.h
//  0825 案例 - 彩票
//
//  Created by 张思琦 on 15/8/30.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQRowModel.h"

@interface SQSettingBaseCell : UITableViewCell


@property (nonatomic, strong) SQRowModel *model;


+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style;


@end
