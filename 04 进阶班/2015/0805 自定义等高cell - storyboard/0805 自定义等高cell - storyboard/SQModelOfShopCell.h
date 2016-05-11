//
//  SQModelOfShopCell.h
//  0805 自定义等高cell - storyboard
//
//  Created by 张思琦 on 15/8/8.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SQModelOfShopInfo;

@interface SQModelOfShopCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *shopImageView;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopBuyCountLabel;


@property (nonatomic, strong) SQModelOfShopInfo *modelOfShopInfo;

@end
