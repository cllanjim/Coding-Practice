//
//  SQCell.h
//  0923 购物车
//
//  Created by 张思琦 on 15/9/23.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQCellDataModel.h"

@interface SQCell : UITableViewCell

@property (nonatomic, strong) SQCellDataModel *dataModel;

@property (nonatomic, weak) IBOutlet UIImageView *wineImageView;
@property (nonatomic, weak) IBOutlet UILabel *wineName;
@property (nonatomic, weak) IBOutlet UILabel *wineMoney;

@end
