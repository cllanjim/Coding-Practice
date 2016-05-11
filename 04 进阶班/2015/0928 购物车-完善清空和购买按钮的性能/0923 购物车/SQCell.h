//
//  SQCell.h
//  0923 购物车
//
//  Created by 张思琦 on 15/9/23.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQCellDataModel.h"

@class SQCell;

//设置代理的协议
@protocol SQCellDelegate <NSObject>
@optional
- (void)sqcelldidClickPlusButton:(SQCell *)cell;
- (void)sqcelldidClickMinusButton:(SQCell *)cell;

@end


@interface SQCell : UITableViewCell

@property (nonatomic, strong) SQCellDataModel *dataModel;

//设置代理
@property (nonatomic, weak) id<SQCellDelegate> delegate;

@end
