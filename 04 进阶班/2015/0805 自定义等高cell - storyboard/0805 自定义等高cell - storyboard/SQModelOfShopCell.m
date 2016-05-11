//
//  SQModelOfShopCell.m
//  0805 自定义等高cell - storyboard
//
//  Created by 张思琦 on 15/8/8.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "SQModelOfShopCell.h"
#import "SQModelOfShopInfo.h"

@implementation SQModelOfShopCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModelOfShopInfo:(SQModelOfShopInfo *)modelOfShopInfo
{
    _modelOfShopInfo = modelOfShopInfo;
    
    self.shopImageView.image = modelOfShopInfo.image;
    self.shopNameLabel.text = modelOfShopInfo.title;
    self.shopBuyCountLabel.text = modelOfShopInfo.buyCount;
    self.shopPriceLabel.text = modelOfShopInfo.price;
}

@end
