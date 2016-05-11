//
//  SQModelOfShop.h
//  0805 自定义等高cell - atuolayout方法
//
//  Created by 张思琦 on 15/8/8.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SQModelOfShopInfo;


@interface SQModelOfShop : UITableViewCell

@property (nonatomic, weak) UIImageView *shopPhotoImageView;

@property (nonatomic, weak) UILabel *shopNameLabel;

@property (nonatomic, weak) UILabel *shopPriceLabel;

@property (nonatomic, weak) UILabel *shopBuyCountLabel;

@property (nonatomic, strong) SQModelOfShopInfo *shopInfo;


@end
