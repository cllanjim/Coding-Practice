//
//  SQModelOfShopCell.m
//  0805 自定义等高cell - xib方法
//
//  Created by 张思琦 on 15/8/8.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "SQModelOfShopCell.h"
#import "SQModelOfShopInfo.h"

@interface SQModelOfShopCell ()

@property (weak, nonatomic) IBOutlet UIImageView *shopImageView;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopBuyCountLabel;


@end


@implementation SQModelOfShopCell


- (void)awakeFromNib {
    
//    self.shopImageView.backgroundColor = [UIColor lightGrayColor];
//    self.shopNameLabel.backgroundColor = [UIColor blackColor];
//    self.shopPriceLabel.backgroundColor = [UIColor orangeColor];
//    self.shopBuyCountLabel.backgroundColor = [UIColor blueColor];
    // Initialization code
}

-(void)setModelOfShopInfo:(SQModelOfShopInfo *)modelOfShopInfo
{
    _modelOfShopInfo = modelOfShopInfo;
    
    self.shopImageView.image = modelOfShopInfo.image;
    self.shopNameLabel.text = modelOfShopInfo.title;
    self.shopPriceLabel.text = modelOfShopInfo.price;
    self.shopBuyCountLabel.text = modelOfShopInfo.buyCount;

}

@end
