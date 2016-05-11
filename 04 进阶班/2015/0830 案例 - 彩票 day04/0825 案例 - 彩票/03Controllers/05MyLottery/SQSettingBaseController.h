//
//  SQSettingBaseController.h
//  0825 案例 - 彩票
//
//  Created by 张思琦 on 15/8/30.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SQSectionModel.h"
#import "SQRowModel.h"
#import "SQArrowRowModel.h"
#import "SQSwitchRowModel.h"


#import "SQSettingBaseCell.h"





@interface SQSettingBaseController : UITableViewController


@property (nonatomic, strong) NSMutableArray *groupOfSectionModel;


@end
